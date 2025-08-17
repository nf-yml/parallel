import org.yaml.snakeyaml.Yaml

// Default parameters
params.logs = './nf-yml-logs'

process worker{
  tag "${sp.name}"
  container "${sp.environment}"
  publishDir "${params.logs}", mode: 'move',
    saveAs: { fn -> "${sp.name}.log" }

  input:
    val(sp)

  output:
    path('.command.log')

  """
  ${sp.command}
  """
}

workflow {
  // Validate input file exists before attempting to parse
  if (!params.in) {
    error "Input file parameter '--in' is required"
  }
  
  def inputFile = new File(params.in)
  if (!inputFile.exists()) {
    error "Input file does not exist: ${params.in}"
  }
  
  if (!inputFile.canRead()) {
    error "Cannot read input file: ${params.in}"
  }
  
  // Parse the input process specs and adjust individual fields as needed
  specs = new Yaml().load(inputFile)
  specs = specs.collect{k, v -> 
    v['name'] = k
    if(!v.containsKey('environment')) v['environment'] = ""
    v
  }

  // Run each command in parallel
  channel.from(specs) | worker
}

