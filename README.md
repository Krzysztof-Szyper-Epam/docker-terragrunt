# Dockerized IaC framework for Terraform, OpenTofu and Terragrunt

### Supporting `amd64` and `aarch64/arm64` images!

### Supporting fully OpenTofu by image version (prefix `ot-`)!


Docker image with Terraform or Terragrunt, together with Terragrunt, Go, Python, Make, Docker, Git, and all needed components to easily manage cloud  infrastructure for CI/CD environments as a runner image.

Including cloud CLIs and SDKs for **Amazon Web Services, Microsoft Azure, Google Cloud Platform and YandexCloud**.

**Best used as runner image for CI/CD in automation, as well as a consistent local run environment.**

Please note focus of those images is to maintain availability of current versions of **Terraform, OpenTofu and Terragrunt**, not CLIs or other dependencies.  
Hence, images are updated when new version of Terraform, OpenTofu or Terragrunt is released. Furthermore, versioning labels of images contain versions of said software to emphasize it.

**Source code is available at [devops-infra/docker-terragrunt](https://github.com/devops-infra/docker-terragrunt).**

Dockerfile was based on two images made
by [cytopia](https://github.com/cytopia): [docker-terragrunt](https://github.com/cytopia/docker-terragrunt)
and [docker-terragrunt-fmt](https://github.com/cytopia/docker-terragrunt-fmt)
.  
Original README files are included in this
repository: [docker-terragrunt](https://github.com/devopsinfra/docker-terragrunt/blob/master/README.docker-terragrunt.md)
and [docker-terragrunt-fmt](https://github.com/devopsinfra/docker-terragrunt/blob/master/README.docker-terragrunt-fmt.md)
. This project grew much bigger than the original ones and is intended to be a framework for cloud
Infrastructure-as-a-Code.


<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-6-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->
[![Push to master](https://img.shields.io/github/workflow/status/devops-infra/docker-terragrunt/Push%20to%20master?color=brightgreen&label=Master%20branch&logo=github&style=flat-square)
](https://github.com/devops-infra/docker-terragrunt/actions?query=workflow%3A%22Push+to+master%22)
[![Push to other](https://img.shields.io/github/workflow/status/devops-infra/docker-terragrunt/Push%20to%20other?color=brightgreen&label=Pull%20requests&logo=github&style=flat-square)
](https://github.com/devops-infra/docker-terragrunt/actions?query=workflow%3A%22Push+to+other%22)
<br>
[
![GitHub](https://img.shields.io/badge/github-devops--infra%2Fdocker--terragrunt-brightgreen.svg?style=flat-square&logo=github)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/devops-infra/docker-terragrunt?color=brightgreen&label=Code%20size&style=flat-square&logo=github)
![GitHub last commit](https://img.shields.io/github/last-commit/devops-infra/docker-terragrunt?color=brightgreen&label=Last%20commit&style=flat-square&logo=github)
](https://github.com/devops-infra/docker-terragrunt "shields.io")
<br>
[
![DockerHub](https://img.shields.io/badge/docker-devopsinfra%2Fdocker--terragrunt-blue.svg?style=flat-square&logo=docker)
![Dockerfile size](https://img.shields.io/github/size/devops-infra/docker-terragrunt/Dockerfile?label=Dockerfile%20size&style=flat-square&logo=docker)
![Docker Pulls](https://img.shields.io/docker/pulls/devopsinfra/docker-terragrunt?color=blue&label=Pulls&logo=docker&style=flat-square)
](https://hub.docker.com/r/devopsinfra/docker-terragrunt "shields.io")

<!--
[
![DockerHub](https://img.shields.io/badge/docker-devopsinfra%2Fdocker--terragrunt:aws--latest-blue.svg?style=flat-square&logo=docker)
![Docker version](https://img.shields.io/docker/v/devopsinfra/docker-terragrunt/aws-latest?color=blue&label=Version&logo=docker&style=flat-square)
![Image size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/aws-latest?label=Image%20size&style=flat-square&logo=docker)
](https://hub.docker.com/r/devopsinfra/docker-terragrunt "shields.io")
<br>
[
![DockerHub](https://img.shields.io/badge/docker-devopsinfra%2Fdocker--terragrunt:azure--latest-blue.svg?style=flat-square&logo=docker)
![Docker version](https://img.shields.io/docker/v/devopsinfra/docker-terragrunt/azure-latest?color=blue&label=Version&logo=docker&style=flat-square)
![Image size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/azure-latest?label=Image%20size&style=flat-square&logo=docker)
](https://hub.docker.com/r/devopsinfra/docker-terragrunt "shields.io")
<br>
[
![DockerHub](https://img.shields.io/badge/docker-devopsinfra%2Fdocker--terragrunt:gcp--latest-blue.svg?style=flat-square&logo=docker)
![Docker version](https://img.shields.io/docker/v/devopsinfra/docker-terragrunt/gcp-latest?color=blue&label=Version&logo=docker&style=flat-square)
![Image size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/gcp-latest?label=Image%20size&style=flat-square&logo=docker)
](https://hub.docker.com/r/devopsinfra/docker-terragrunt "shields.io")
-->


# Available source images

Tag of the image tells which version of Terraform and Terragrunt it contains and which public cloud provider CLI it's
bundled with or not (see second table below).


| Current release full tag version value |
|:---------------------------------------|
| `tf-1.10.4-ot-1.9.0-tg-0.71.5`         |


| Registry                                                                             | Example full image name                                                       | Image name          | Image version        | Terraform version | OpenTofu version | Terragrunt version |
|--------------------------------------------------------------------------------------|-------------------------------------------------------------------------------|---------------------|----------------------|-------------------|------------------|--------------------|
| [Docker Hub](https://hub.docker.com/repository/docker/devopsinfra/docker-terragrunt) | `devopsinfra/docker-terragrunt:tf-1.10.4-tg-0.71.5`                            | `docker-terragrunt` | `tf-1.10.4-tg-0.71.5` | `1.10.4`           | `N/A`            | `0.71.5`           |
| [Docker Hub](https://hub.docker.com/repository/docker/devopsinfra/docker-terragrunt) | `devopsinfra/docker-terragrunt:ot-1.9.0-tg-0.71.5`                            | `docker-terragrunt` | `ot-1.9.0-tg-0.71.5` | `N/A`             | `1.9.0`          | `0.71.5`           |
| [GitHub Packages](https://github.com/devops-infra/docker-terragrunt/packages)        | `ghcr.io/devops-infra/docker-terragrunt/docker-terragrunt:tf-1.10.4-tg-0.71.5` | `docker-terragrunt` | `tf-1.10.4-tg-0.71.5` | `1.10.4`           | `N/A`            | `0.71.5`           |
| [GitHub Packages](https://github.com/devops-infra/docker-terragrunt/packages)        | `ghcr.io/devops-infra/docker-terragrunt/docker-terragrunt:ot-1.9.0-tg-0.71.5` | `docker-terragrunt` | `ot-1.9.0-tg-0.71.5` | `N/A`             | `1.9.0`          | `0.71.5`           |


# Available flavours

Tag of the image tells also which cloud API/SDK is included in the image.

| Image name                                           | AWS | Azure | GCP | OT | TF | Description                                            | Size                                                                                                                                                            |
|------------------------------------------------------|-----|-------|-----|----|----|--------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `docker-terragrunt:slim-tf-1.10.4-tg-0.71.5`          | ❌   | ❌     | ❌   | ❌  | ✅  | Lightweight version with TF, TG and bare dependencies  | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/slim-tf-latest?label=Image%20size&style=flat-square&logo=docker)          |
| `docker-terragrunt:slim-ot-1.9.0-tg-0.71.5`          | ❌   | ❌     | ❌   | ✅  | ❌  | Lightweight version with OT, TG and bare dependencies  | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/slim-ot-latest?label=Image%20size&style=flat-square&logo=docker)          |
| `docker-terragrunt:tf-1.10.4-tg-0.71.5`               | ❌   | ❌     | ❌   | ❌  | ✅  | Normal version, with TF. Having Go, Python, Make, etc. | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/tf-latest?label=Image%20size&style=flat-square&logo=docker)               |
| `docker-terragrunt:ot-1.9.0-tg-0.71.5`               | ❌   | ❌     | ❌   | ✅  | ❌  | Normal version, with OT. Having Go, Python, Make, etc. | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/ot-latest?label=Image%20size&style=flat-square&logo=docker)               |
| `docker-terragrunt:aws-tf-1.10.4-tg-0.71.5`           | ✅   | ❌     | ❌   | ❌  | ✅  | Normal version with AWS CLI, with TF.                  | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/aws-tf-latest?label=Image%20size&style=flat-square&logo=docker)           |
| `docker-terragrunt:aws-ot-1.9.0-tg-0.71.5`           | ✅   | ❌     | ❌   | ✅  | ❌  | Normal version with AWS CLI, with OT.                  | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/aws-ot-latest?label=Image%20size&style=flat-square&logo=docker)           |
| `docker-terragrunt:azure-tf-1.10.4-tg-0.71.5`         | ❌   | ✅     | ❌   | ❌  | ✅  | Normal version with Azure CLI, with TF.                | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/azure-tf-latest?label=Image%20size&style=flat-square&logo=docker)         |
| `docker-terragrunt:azure-ot-1.9.0-tg-0.71.5`         | ❌   | ✅     | ❌   | ✅  | ❌  | Normal version with Azure CLI, with OT.                | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/azure-ot-latest?label=Image%20size&style=flat-square&logo=docker)         |
| `docker-terragrunt:aws-azure-tf-1.10.4-tg-0.71.5`     | ✅   | ✅     | ❌   | ❌  | ✅  | Normal version with AWS and Azure CLIs, with TF.       | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/aws-azure-tf-latest?label=Image%20size&style=flat-square&logo=docker)     |
| `docker-terragrunt:aws-azure-ot-1.9.0-tg-0.71.5`     | ✅   | ✅     | ❌   | ✅  | ❌  | Normal version with AWS and Azure CLIs, with OT.       | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/aws-azure-ot-latest?label=Image%20size&style=flat-square&logo=docker)     |
| `docker-terragrunt:gcp-tf-1.10.4-tg-0.71.5`           | ❌   | ❌     | ✅   | ❌  | ✅  | Normal version with GCP CLI, with TF.                  | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/gcp-tf-latest?label=Image%20size&style=flat-square&logo=docker)           |
| `docker-terragrunt:gcp-ot-1.9.0-tg-0.71.5`           | ❌   | ❌     | ✅   | ✅  | ❌  | Normal version with GCP CLI, with OT.                  | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/gcp-ot-latest?label=Image%20size&style=flat-square&logo=docker)           |
| `docker-terragrunt:aws-gcp-tf-1.10.4-tg-0.71.5`       | ✅   | ❌     | ✅   | ❌  | ✅  | Normal version with AWS and GCP CLIs, with TF.         | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/aws-gcp-tf-latest?label=Image%20size&style=flat-square&logo=docker)       |
| `docker-terragrunt:aws-gcp-ot-1.9.0-tg-0.71.5`       | ✅   | ❌     | ✅   | ✅  | ❌  | Normal version with AWS and GCP CLIs, with OT.         | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/aws-gcp-ot-latest?label=Image%20size&style=flat-square&logo=docker)       |
| `docker-terragrunt:azure-gcp-tf-1.10.4-tg-0.71.5`     | ❌   | ✅     | ✅   | ❌  | ✅  | Normal version with Azure and GCP CLIs, with TF.       | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/azure-gcp-tf-latest?label=Image%20size&style=flat-square&logo=docker)     |
| `docker-terragrunt:azure-gcp-ot-1.9.0-tg-0.71.5`     | ❌   | ✅     | ✅   | ✅  | ❌  | Normal version with Azure and GCP CLIs, with OT.       | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/azure-gcp-ot-latest?label=Image%20size&style=flat-square&logo=docker)     |
| `docker-terragrunt:aws-azure-gcp-tf-1.10.4-tg-0.71.5` | ✅   | ✅     | ✅   | ❌  | ✅  | Normal version with AWS, Azure and GCP CLIs, with TF.  | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/aws-azure-gcp-tf-latest?label=Image%20size&style=flat-square&logo=docker) |
| `docker-terragrunt:aws-azure-gcp-ot-1.9.0-tg-0.71.5` | ✅   | ✅     | ✅   | ✅  | ❌  | Normal version with AWS, Azure and GCP CLIs, with OT.  | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/aws-azure-gcp-ot-latest?label=Image%20size&style=flat-square&logo=docker) |
| `docker-terragrunt:yc-tf-1.10.4-tg-0.71.5`            | ❌   | ❌     | ❌   | ❌  | ✅  | Normal version with YandexCloud CLI, with TF.          | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/yc-tf-latest?label=Image%20size&style=flat-square&logo=docker)            |
| `docker-terragrunt:yc-ot-1.9.0-tg-0.71.5`            | ❌   | ❌     | ❌   | ✅  | ❌  | Normal version with YandexCloud CLI, with OT.          | ![Docker size](https://img.shields.io/docker/image-size/devopsinfra/docker-terragrunt/yc-ot-latest?label=Image%20size&style=flat-square&logo=docker)            |


# Usage

* For working with local files - mount working directory under `/data`, e.g. `--volume $(pwd):/data`.
* For working with cloud providers - pass their credentials as additional file or environment variables,  
  e.g. `--env AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}` or `--volume ~/.aws/credentials:/root/.aws/credentials`.
* For running other Docker images - by sharing the socket,  
  e.g. `--privileged --volume /var/run/docker.sock:/var/run/docker.sock`.
* For configuring git - mount desired `.gitconfig` and/or SSH key (if needed),  
  e.g. `--volume ~/.gitconfig:/root/.gitconfig --volume ~/.ssh/id_rsa_github:/root/.ssh/id_rsa`


### Examples of `.gitconfig` to mount

* Use https with Personal Access Token:
```
[url "https://{GITHUB_TOKEN}@github.com/"]
	insteadOf = https://github.com/
[url "https://{GITHUB_TOKEN}@github.com/"]
	insteadOf = git+ssh://github.com/
[url "https://{GITHUB_TOKEN}@github.com/"]
	insteadOf = git@github.com:
```

* Use https instead of git/ssh:
```
[url "https://github.com/"]
	insteadOf = git+ssh://github.com/
[url "https://github.com/"]
	insteadOf = git@github.com:
```

* Use ssh instead of https:
```
[url "ssh://git@github.com/"]
  insteadOf = https://github.com/
[url "ssh://git@github.com/"]
	insteadOf = git@github.com:
```


# Examples

* Format all HCL files in the current directory. Including subdirectories.

```bash
docker run --rm \
    --user $(id -u):$(id -g) \
    --volume $(pwd):/data \
    devopsinfra/docker-terragrunt:latest format-hcl
```

* Plan terraform deployment in AWS for files in current directory.

```bash
docker run --rm \
    --tty --interactive \
    --env AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} \
    --env AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
    --env AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
    --env AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN} \
    --user $(id -u):$(id -g) \
    --volume $(pwd):/data \
    devopsinfra/docker-terragrunt:aws-latest terraform plan
```

* Apply terragrunt deployment in subdirectory. With GitHub using a `~/.gitconfig` file with PAT.

```bash
docker run --rm \
    --tty --interactive \
    --user $(id -u):$(id -g) \
    --volume $(pwd):/data \
    --volume ~/.gitconfig:/root/.gitconfig \
    devopsinfra/docker-terragrunt:aws-latest terragrunt apply --terragrunt-working-dir some/module
```

* Run a Makefile target as orchestration script.

```bash
docker run --rm \
    --tty --interactive \
    --user $(id -u):$(id -g) \
    --volume $(pwd):/data \
    devopsinfra/docker-terragrunt:aws-latest make build
```


# Additional software available in all images

### Scripts

| Script name         | Is included in PATH | Purpose                                                                                                                            | Source/Documentation                                                                           |
|---------------------|---------------------|------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------|
| `format-hcl`        | Yes                 | For formatting all HCL files (`.hcl`, `.tf` and `.tfvars`) into format suggested by [Hashicorp](https://github.com/hashicorp/hcl). | [devops-infra](https://github.com/devops-infra/docker-terragrunt/blob/master/fmt/format-hcl)   |
| `terragrunt-fmt.sh` | No                  | Dependency for `format-hcl`                                                                                                        | [cytopia](https://github.com/cytopia/docker-terragrunt-fmt/blob/master/data/terragrunt-fmt.sh) |
| `show-versions.sh`  | Yes                 | Main CMD target for Docker image, just to show all installed binaries versions.                                                    | [devops-infra](https://github.com/devops-infra/docker-terragrunt/blob/master/show-versions.sh) |


### Binaries and Python libraries

Some are conditional, depending on the selected flavour, marked with `*`

| Name                | Type           | Description                                                                                                                                                    | Source/Documentation                               |
|---------------------|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------|
| *awscli**           | Binary         | For interacting with AWS via terminal.                                                                                                                         | https://github.com/aws/aws-cli                     |
| *azure-cli**        | Binary         | For interacting with Azure via terminal.                                                                                                                       | https://github.com/Azure/azure-cli                 |
| bc                  | Binary         | For numeric operations.                                                                                                                                        | https://www.gnu.org/software/bc/bc.html            |
| *boto3**            | Python library | For interacting with AWS via Python.                                                                                                                           | https://github.com/boto/boto3                      |
| cloudflare          | Python library | For Cloudflare API operations                                                                                                                                  | https://github.com/cloudflare/python-cloudflare    |
| curl                | Binary         | For interacting with [ElasticSearch](https://github.com/elastic/elasticsearch) and [Kibana](https://github.com/elastic/kibana).                                | https://curl.haxx.se/                              |
| docker              | Binary         | For running another container, e.g. for deploying Lambdas with [LambCI's](https://github.com/lambci) [docker-lambda](https://github.com/lambci/docker-lambda). | https://github.com/docker/docker-ce                |
| git                 | Binary         | For interacting with [Github](https://github.com) repositories.                                                                                                | https://git-scm.com/                               |
| go                  | Binary         | For using Golang, e.g. easy install of additional libraries/binaries.                                                                                          | https://go.dev/                                    |
| *google-cloud-sdk** | Binary         | For interacting with GCP via terminal.                                                                                                                         | https://cloud.google.com/sdk                       |
| gnupg               | Binary         | For GPG operations.                                                                                                                                            | https://gnupg.org/                                 |
| graphviz            | Binary         | For generating graphic files from dot graphs, like `terraform graph`.                                                                                          | https://graphviz.org/                              |
| hub                 | Binary         | For interacting with [Github](https://github.com) APIs.                                                                                                        | https://github.com/github/hub                      |
| jq                  | Binary         | For parsing JSON outputs of [awscli](https://github.com/aws/aws-cli).                                                                                          | https://stedolan.github.io/jq/                     |
| hcledit             | Binary         | For reading and writing HCL files.                                                                                                                             | https://github.com/minamijoyo/hcledit              |
| make                | Binary         | For using `Makefile` instead of scripts in deployment process.                                                                                                 | https://www.gnu.org/software/make/                 |
| ncurses             | Binary         | For expanding `Makefile` with some colors.                                                                                                                     | https://invisible-island.net/ncurses/announce.html |
| openssh             | Binary         | For allowing outgoing SSH connections.                                                                                                                         | https://www.openssh.com/                           |
| openssl             | Binary         | For calculating BASE64SHA256 hash of Lambda packages. Assures updating Lambdas only when package hash changed.                                                 | https://github.com/openssl/openssl                 |
| opentofu            | Binary         | As open-source alternative to Terraform.                                                                                                                       | https://github.com/opentofu/opentofu               |
| PyGithub            | Python library | For interacting with GitHub API.                                                                                                                               | https://github.com/PyGithub/PyGithub               |
| python-hcl2         | Python library | For reading HCL files in Python.                                                                                                                               | https://github.com/amplify-education/python-hcl2   |
| python3             | Binary         | For running more complex scripts during deployment process.                                                                                                    | https://www.python.org/                            |
| requests            | Python library | For sending HTTP requests, for example integration with Slack                                                                                                  | https://github.com/psf/requests                    |
| slack_sdk           | Python library | For integration with Slack applications/bots, e.g. creating channels for notifications                                                                         | https://github.com/slackapi/python-slack-sdk       |
| sops                | Binary         | For encrypting config files for Terragrunt's `sops_decrypt_file`.                                                                                              | https://github.com/mozilla/sops/                   |
| terraform           | Binary         | For managing IaC. Dependency for [Terragrunt](https://github.com/gruntwork-io/terragrunt).                                                                     | https://github.com/hashicorp/terraform             |
| terragrunt          | Binary         | For managing IaC. Wrapper over [Terraform](https://github.com/hashicorp/terraform).                                                                            | https://github.com/gruntwork-io/terragrunt         |
| tflint              | Binary         | For linting Terraform files.                                                                                                                                   | https://github.com/terraform-linters/tflint        |
| unzip               | Binary         | For extracting packages.                                                                                                                                       | http://infozip.sourceforge.net/                    |
| yc                  | Binary         | For interaction with Yandex Cloud via terminal.                                                                                                                | https://cloud.yandex.com/en/docs/cli               |
| zip                 | Binary         | For creating packages for Lambdas.                                                                                                                             | http://infozip.sourceforge.net/                    |


## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://shyper.pro/"><img src="https://avatars.githubusercontent.com/u/45788587?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Krzysztof Szyper</b></sub></a><br /><a href="https://github.com/devops-infra/docker-terragrunt/commits?author=ChristophShyper" title="Code">💻</a> <a href="#platform-ChristophShyper" title="Packaging/porting to new platform">📦</a> <a href="#maintenance-ChristophShyper" title="Maintenance">🚧</a></td>
    <td align="center"><a href="https://www.everythingcli.org/"><img src="https://avatars.githubusercontent.com/u/1.7.5999?v=4?s=100" width="100px;" alt=""/><br /><sub><b>cytopia</b></sub></a><br /><a href="#ideas-cytopia" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/devops-infra/docker-terragrunt/commits?author=cytopia" title="Code">💻</a></td>
    <td align="center"><a href="https://evaate.com/"><img src="https://avatars.githubusercontent.com/u/12538173?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Marko Djukic</b></sub></a><br /><a href="https://github.com/devops-infra/docker-terragrunt/commits?author=markodjukic" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/clushie"><img src="https://avatars.githubusercontent.com/u/47661139?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Phileas Lebada</b></sub></a><br /><a href="#ideas-clushie" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://github.com/SmedbergM"><img src="https://avatars.githubusercontent.com/u/3883154?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Matthew Smedberg</b></sub></a><br /><a href="https://github.com/devops-infra/docker-terragrunt/commits?author=SmedbergM" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/dsoudakov"><img src="https://avatars.githubusercontent.com/u/14098629?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Dmitri</b></sub></a><br /><a href="https://github.com/devops-infra/docker-terragrunt/issues?q=author%3Adsoudakov" title="Bug reports">🐛</a> <a href="https://github.com/devops-infra/docker-terragrunt/commits?author=dsoudakov" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification.
Contributions of any kind welcome!