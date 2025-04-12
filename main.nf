import org.yaml.snakeyaml.Yaml

process worker{
  tag "${sp.name}"
  container "${sp.environment}"

  input:
    val(sp)

  """
  ${sp.command}
  """
}

workflow {
  // Parse the input process specs and adjust individual fields as needed
  specs = new Yaml().load(new File(params.in))
  specs = specs.collect{k, v -> 
    v['name'] = k
    if(!v.containsKey('environment')) v['environment'] = ""
    v
  }

  channel.from(specs) | worker
}

