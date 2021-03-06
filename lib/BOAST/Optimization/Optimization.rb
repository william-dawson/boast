module BOAST

  class OptimizationParameter
    attr_reader :name
    attr_reader :values
    def initialize( name, values )
      @name = name
      @values = values
    end
  end

  class BooleanParameter < OptimizationParameter
    def initialize( name )
      super( name, [false, true] )
    end
  end

  OP = OptimizationParameter
  BP = BooleanParameter

  class OptimizationSpace
    attr_reader :parameters
    attr_reader :rules
    attr_reader :checkers
    HASH_NAME = "options"

    def initialize( *parameters )
      @rules = nil
      @checkers = nil
      if parameters.length == 1 and parameters[0].is_a?(Hash) then
        @parameters = []
        parameters[0].each { |key, value|
          if key == :rules then
            @rules = [value].flatten
            format_rules
          elsif key == :checkers then
            @checkers = [value].flatten
          else
            @parameters.push( OptimizationParameter::new(key, value) )
          end
        }
      else
        @parameters = parameters
      end
      if @checkers then
        @checkers.each { |checker| eval checker }
      end
      if @rules then
        s = <<EOF
  def rules_checker(#{HASH_NAME})
    return ( (#{@rules.join(") and (")}) )
  end
EOF
      else
s = <<EOF
  def rules_checker(#{HASH_NAME})
    return true
  end
EOF
      end
      eval s
    end

    # Add to the parameters of the rules the name of the hash variable
    def format_rules
      regxp = /(?<!#{HASH_NAME}\[):\w+(?!\])/
      @rules.each{|r|
        matches = r.scan(regxp)
        matches = matches.uniq
        matches.each{ |m|
          r.gsub!(/(?<!#{HASH_NAME}\[)#{m}(?!\])/, "#{HASH_NAME}[#{m}]")
        }
      }
    end

    # Remove all points that do not meet ALL the rules.
    def remove_unfeasible (points = [])
      if @rules then
        points.select!{ |pt|
          rules_checker(pt)
        }
      end
      return points
    end

    def to_h
      h = {}
      @parameters.each { |p|
        h[p.name] = p.values
      }
      h[:rules] = @rules if @rules
      h[:checkers] = @checkers if @checkers
      return h
    end
  end

  class Optimizer
    include PrivateStateAccessor
    attr_reader :experiments
    attr_reader :search_space
    attr_reader :log
    attr_reader :history

    def initialize(search_space, options = {} )
      @search_space = search_space
      @experiments = 0
      @log = {}
    end
  end

  class GeneticOptimizer < Optimizer

    def initialize(search_space, options = {} )
      super
      require 'darwinning'
      s = <<EOF
      @organism = Class::new(Darwinning::Organism) do
        @@block = nil
        def self.block
          return @@block
        end
        def self.block=(block)
          @@block = block
        end
        @@experiments = 0
        def self.experiments
          return @@experiments
        end
        def self.experiments=(experiments)
          @@experiments = experiments
        end
EOF
      @search_space.parameters.each { |param|
      s += <<EOF
        @genes.push( Darwinning::Gene.new(name: #{param.name.inspect}, value_range: #{param.values.inspect}) )
EOF
      }
      s += <<EOF
        def initialize(*args)
          super
        end

        def fitness
          return @fitness if @fitness
          opts = {}
          genes.each { |gene|
            opts[gene.name] = genotypes[gene]
          }
          @fitness = @@block.call(opts)
          @@experiments = @@experiments + 1
          return fitness
        end

        def to_a
          opts = {}
          genes.each { |gene|
            opts[gene.name] = genotypes[gene]
          }
          return [opts, fitness]
        end

        def to_s
          return to_a.to_s
        end

      end
EOF
      eval s
    end

    def optimize(options={}, &block)
      opts = { :population_size => 20,
               :fitness_goal => 0,
               :generations_limit => 100,
               :search_space => @search_space }
      opts.update(options)
      opts[:organism] = @organism
      @organism.block = block
      @organism.experiments = 0
      population = Darwinning::Population.new(opts)
      population.evolve!
      @history = population.history
      @experiments = @organism.experiments
      return population.best_member.to_a
    end

  end

  class BruteForceOptimizer < Optimizer

    def initialize(search_space, options = {} )
      super
      @randomize = options[:randomize]
      @checkpoint = options[:checkpoint]
      @checkpoint_size = options[:checkpoint_size]
      @seed = options[:seed]
    end

#    def points
#      array = @search_space.parameters.collect { |p| p.values.collect { |val| [p.name,val] } }
#      pts = array[0]
#      pts = pts.product(*array[1..-1]) if array.length > 1
#      pts = pts.collect { |a| Hash[ *a.flatten ] }
#      return pts.select{ |pt| @search_space.rules_checker(pt) }
#    end

    def to_a
      return each.to_a
    end

    alias points to_a

    def each
      array = @search_space.parameters.collect { |p| [p.name,p.values.to_a] }
      lazy_block = lambda { |rank, data|
        array[rank][1].each { |d|
          data[array[rank][0]] = d
          if rank == array.length - 1 then
            yield data.dup if @search_space.rules_checker(data)
          else
            lazy_block.call(rank+1, data)
          end
        }
      }
      if block_given? then
        lazy_block.call(0, {})
        return self
      else
        return to_enum(:each)
      end
    end

    def each_random( &block)
      self.points.shuffle.each(&block)
      return self if block_given?
    end

    def optimize(&block)
      @experiments = 0
      @log = {}
      best = [nil, Float::INFINITY]
      e = each
      
      if @randomize then
        e = e.to_a
        (@seed ? e.shuffle!(random: Random.new(@seed)) : e.shuffle!)
      end
      e = e.drop(@checkpoint).take(@checkpoint_size) if @checkpoint_size

      e.each { |config|
        @experiments += 1
        metric = block.call(config)
        @log[config] = metric if optimizer_log
        best = [config, metric] if metric < best[1]
      }
      if optimizer_log_file then
        File::open(File::basename(optimizer_log_file,".yaml")+".yaml", "w") { |f|
          f.print YAML::dump(@log)
        }
        File::open(File::basename(optimizer_log_file,".yaml")+"_parameters.yaml", "w") { |f|
          f.print YAML::dump(@search_space.to_h)
        }
      end
      return best
    end

  end

  # @private
  class GenericOptimization

    attr_accessor :repeat
    attr_reader :parameters

    def size
      return @parameters.size
    end

    def points
      params2 = @parameters.dup
      param = params2.shift
      pts = param.values.collect { |val| {param.name => val} }
      if params2.size == 0 then
        return pts
      else
        optim2 = GenericOptimization::new(*params2)
        pts3=[]
        pts.each{ |p1|
          optim2.each { |p2|
            pts3.push(p1.dup.update(p2))
          }
        }
        return pts3
      end
    end

    def each(&block)
      return self.points.each(&block)
    end

    def each_random(&block)
      return self.points.shuffle.each(&block)
    end

    def initialize( *parameters )
      if parameters.length == 1 and parameters[0].is_a?(Hash) then
        @parameters = []
        parameters[0].each { |key, value|
          @parameters.push( OptimizationParameter::new(key, value) )
        }
      else
        @parameters = parameters
      end
      @repeat = 3
    end

  end

end
