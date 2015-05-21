Gem::Specification.new do |s|
  s.name = 'BOAST'
  s.version = "1.0.2"
  s.author = "Brice Videau"
  s.email = "brice.videau@imag.fr"
  s.homepage = "https://github.com/Nanosim-LIG/boast"
  s.summary = "BOAST is a computing kernel metaprogramming tool."
  s.description = "BOAST aims at providing a framework to metaprogram, benchmark and validate computing kernels"
  s.files = %w( BOAST.gemspec
                LICENSE
                lib/BOAST.rb
                lib/BOAST/Algorithm.rb
                lib/BOAST/CKernel.rb
                lib/BOAST/BOAST_OpenCL.rb
                lib/BOAST/Transitions.rb
                lib/BOAST/Parens.rb
                lib/BOAST/Operators.rb
                lib/BOAST/DataTypes.rb
                lib/BOAST/Arithmetic.rb
                lib/BOAST/Expression.rb
                lib/BOAST/Index.rb
                lib/BOAST/Variable.rb
                lib/BOAST/Procedure.rb
                lib/BOAST/If.rb
                lib/BOAST/For.rb
                lib/BOAST/Case.rb
                lib/BOAST/While.rb
                lib/BOAST/FuncCall.rb
                lib/BOAST/Pragma.rb
                lib/BOAST/Inspectable.rb
                lib/BOAST/Functors.rb
                lib/BOAST/ControlStructure.rb
                lib/BOAST/Print.rb
                lib/BOAST/State.rb
                lib/BOAST/Optimization.rb
                lib/BOAST/OpenMP.rb
                lib/BOAST/Slice.rb
              )
  s.has_rdoc = true
  s.license = 'BSD'
  s.required_ruby_version = '>= 1.9.3'
  s.add_dependency 'narray', '~> 0.6.0', '>=0.6.0.8'
  s.add_dependency 'opencl_ruby_ffi', '>=0.4'
  s.add_dependency 'systemu', '~> 2', '>=2.2.0'
  s.add_dependency 'os', '~> 0.9', '>=0.9.6'
  s.add_dependency 'PAPI', '>=0.101'
end
