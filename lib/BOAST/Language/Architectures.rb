module BOAST
X86architectures ={"pentium2"=>["MMX"],
 "pentium3"=>["MMX", "SSE"],
 "pentium3m"=>["MMX", "SSE"],
 "pentium-m"=>["MMX", "SSE", "SSE2"],
 "pentium4"=>["MMX", "SSE", "SSE2"],
 "pentium4m"=>["MMX", "SSE", "SSE2"],
 "prescott"=>["MMX", "SSE", "SSE2", "SSE3"],
 "nocona"=>["MMX", "SSE", "SSE2", "SSE3"],
 "core2"=>["MMX", "SSE", "SSE2", "SSE3", "SSSE3"],
 "nehalem"=>
  ["MMX", "SSE", "SSE2", "SSE3", "SSSE3", "SSE4.1", "SSE4.2", "POPCNT"],
 "westmere"=>
  ["MMX",
   "SSE",
   "SSE2",
   "SSE3",
   "SSSE3",
   "SSE4.1",
   "SSE4.2",
   "POPCNT",
   "AES",
   "PCLMUL"],
 "sandybridge"=>
  ["MMX",
   "SSE",
   "SSE2",
   "SSE3",
   "SSSE3",
   "SSE4.1",
   "SSE4.2",
   "POPCNT",
   "AVX",
   "AES",
   "PCLMUL"],
 "ivybridge"=>
  ["MMX",
   "SSE",
   "SSE2",
   "SSE3",
   "SSSE3",
   "SSE4.1",
   "SSE4.2",
   "POPCNT",
   "AVX",
   "AES",
   "PCLMUL",
   "FSGSBASE",
   "RDRND",
   "F16C"],
 "haswell"=>
  ["MOVBE",
   "MMX",
   "SSE",
   "SSE2",
   "SSE3",
   "SSSE3",
   "SSE4.1",
   "SSE4.2",
   "POPCNT",
   "AVX",
   "AVX2",
   "AES",
   "PCLMUL",
   "FSGSBASE",
   "RDRND",
   "FMA",
   "BMI",
   "BMI2",
   "F16C"],
 "broadwell"=>
  ["MOVBE",
   "MMX",
   "SSE",
   "SSE2",
   "SSE3",
   "SSSE3",
   "SSE4.1",
   "SSE4.2",
   "POPCNT",
   "AVX",
   "AVX2",
   "AES",
   "PCLMUL",
   "FSGSBASE",
   "RDRND",
   "FMA",
   "BMI",
   "BMI2",
   "F16C",
   "RDSEED",
   "ADCX",
   "PREFETCHW"],
 "knl"=>
  ["MOVBE",
   "MMX",
   "SSE",
   "SSE2",
   "SSE3",
   "SSSE3",
   "SSE4.1",
   "SSE4.2",
   "POPCNT",
   "AVX",
   "AVX2",
   "AES",
   "PCLMUL",
   "FSGSBASE",
   "RDRND",
   "FMA",
   "BMI",
   "BMI2",
   "F16C",
   "RDSEED",
   "ADCX",
   "PREFETCHW",
   "AVX512F",
   "AVX512PF",
   "AVX512ER",
   "AVX512CD"],
 "bonnell"=>["MOVBE", "MMX", "SSE", "SSE2", "SSE3", "SSSE3"],
 "silvermont"=>
  ["MOVBE",
   "MMX",
   "SSE",
   "SSE2",
   "SSE3",
   "SSSE3",
   "SSE4.1",
   "SSE4.2",
   "POPCNT",
   "AES",
   "PCLMUL",
   "RDRND"],
 "bdver1"=>
  ["FMA4",
   "AVX",
   "XOP",
   "LWP",
   "AES",
   "PCL_MUL",
   "CX16",
   "MMX",
   "SSE",
   "SSE2",
   "SSE3",
   "SSE4A",
   "SSSE3",
   "SSE4.1",
   "SSE4.2",
   "ABM"],
 "bdver2"=>
  ["BMI",
   "TBM",
   "F16C",
   "FMA",
   "FMA4",
   "AVX",
   "XOP",
   "LWP",
   "AES",
   "PCL_MUL",
   "CX16",
   "MMX",
   "SSE",
   "SSE2",
   "SSE3",
   "SSE4A",
   "SSSE3",
   "SSE4.1",
   "SSE4.2",
   "ABM"],
 "bdver3"=>
  ["BMI",
   "TBM",
   "F16C",
   "FMA",
   "FMA4",
   "FSGSBASE",
   "AVX",
   "XOP",
   "LWP",
   "AES",
   "PCL_MUL",
   "CX16",
   "MMX",
   "SSE",
   "SSE2",
   "SSE3",
   "SSE4A",
   "SSSE3",
   "SSE4.1",
   "SSE4.2",
   "ABM"],
 "bdver4"=>
  ["BMI2",
   "TBM",
   "F16C",
   "FMA",
   "FMA4",
   "FSGSBASE",
   "AVX",
   "AVX2",
   "XOP",
   "LWP",
   "AES",
   "PCL_MUL",
   "CX16",
   "MOVBE",
   "MMX",
   "SSE",
   "SSE2",
   "SSE3",
   "SSE4A",
   "SSSE3",
   "SSE4.1",
   "SSE4.2",
   "ABM"],
 "btver1"=>["MMX", "SSE", "SSE2", "SSE3", "SSSE3", "SSE4A", "CX16", "ABM"],
 "btver2"=>
  ["MOVBE",
   "F16C",
   "BMI",
   "AVX",
   "PCL_MUL",
   "AES",
   "SSE4.2",
   "SSE4.1",
   "CX16",
   "ABM",
   "SSE4A",
   "SSSE3",
   "SSE3",
   "SSE2",
   "SSE",
   "MMX"]}
  private_constant :X86architectures
end
