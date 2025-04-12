import org.yaml.snakeyaml.Yaml

process worker{
  tag "${sp.name}"

  input:
    val(sp)

  """
  ${sp.command}
  """
}

workflow {
  // Parse the input process specs and fold key names into a list
  specs = new Yaml().load(new File(params.in))
  specs = specs.collect{k, v -> v['name'] = k; v}

  channel.from(specs) | worker
}

