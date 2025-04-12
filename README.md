# Parallel execution of processes

Nextflow will act as a head process and will oversee parallel execution of commands.
The execution is compatible with all standard Nextflow features (e.g., resource definitions, remote execution, automatic process restarting, etc.).
The Nextflow process will block the shell, acting effectively as a `join` operator for integrating parallel processes back into a common execution flow.

**Step 0:** Install [Nextflow](https://nextflow.io/)

**Step 1:** Define a YAML file with the desired commands and execution environments (in the form of Docker containers)

``` yaml
# Execute this command inside the ubuntu container
greet:
  command: echo Hello World
  environment: ubuntu:latest

# Execute this command inside the python container
maths:
  command: python -c "print(2+2)"
  environment: python:latest

# When an environment is not provided, command execution will be local
# i.e., in the same environment as the head Nextflow process
sleepy time:
  command: sleep 5
```

**Step 2:** Provide the YAML file as input

``` bash
nextflow run nf-yml/parallel --in test.yml
```

By default, the logs from individual commands will be written to `nf-yml-logs`.
You can change that to another directory, e.g., `mylogs`, with

``` bash
nextflow run nf-yml/parallel --in test.yml --logs mylogs
```
