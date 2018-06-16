# python

To vendor python package into your release, run:

```
$ bosh vendor-package python-2.7 ~/workspace/bosh-packages/python-release
```

Included packages:

- python-2.7

To use `python-*` package for compilation in your packaging script:

```bash
#!/bin/bash -eu
source /var/vcap/packages/python-2.7/bosh/compile.env
bosh_generate_runtime_env
bosh_pip <python-module to install> ...
```

To use `python-*` package at runtime in your job scripts:

```bash
#!/bin/bash -eu
source /var/vcap/packages/python-2.7/bosh/runtime.env
source /var/vcap/packages/your-package/bosh/runtime.env
python ...
```

See [packages/python-2.7-test](packages/python-2.7-test) and [jobs/python-2.7-test](jobs/python-2.7-test) for example.
