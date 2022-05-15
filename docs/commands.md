<!-- Space: Projects -->
<!-- Parent: TerraformAwsOpenVpn -->
<!-- Title: Commands TerraformAwsOpenVpn -->

<!-- Label: TerraformAwsOpenVpn -->
<!-- Label: Project -->
<!-- Label: Commands -->
<!-- Include: disclaimer.md -->
<!-- Include: ac:toc -->

## Commands

### Terragrunt

| Field  |        Description        |
| ------ | :-----------------------: |
| REGION |       region of aws       |
| STAGE  | stage or name environment |

```bash
task terragrunt:init REGION=us-east-1 STAGE=core
```

```bash
task terragrunt:apply REGION=us-east-1 STAGE=core
```

```bash
task terragrunt:plan REGION=us-east-1 STAGE=core
```

```bash
task terragrunt:destroy REGION=us-east-1 STAGE=core
```

#### Import

| Field   |           Description           |
| ------- | :-----------------------------: |
| REGION  |          region of aws          |
| STAGE   |    stage or name environment    |
| COMMAND | command for execute with import |

```bash
task terragrunt:import REGION=us-east-1 STAGE=core COMMAND=module.repository_learn_go.github_repository.this learn-go
```

**example**

```bash
task terragrunt:import REGION=us-east-1 STAGE=core COMMAND=module.repository_learn_go.github_repository.this learn-go
```

#### Module

| Field  |        Description        |
| ------ | :-----------------------: |
| REGION |       region of aws       |
| STAGE  | stage or name environment |
| MODULE |  module name to destroy   |

```bash
task terragrunt:module:destroy REGION=us-east-1 STAGE=core MODULE=repository_eslint_config
```

#### State

| Field   |          Description           |
| ------- | :----------------------------: |
| REGION  |         region of aws          |
| STAGE   |   stage or name environment    |
| COMMAND | command for execute with state |

```bash
task terragrunt:state REGION=us-east-1 STAGE=core COMMAND=list
```

### Confluence

#### Sync Markdown with confluence

```{.bash}
task mark:sync
```

### Diagrams

#### Publish diagrams

```{.bash}
task diagrams:publish
```

### Changelog

#### Generate Changelog Next Tag

```{.bash}
task changelog:next APP_TAG={{tag name}}
```

#### Parameters

| Name     | Description   | sample | Required |
| -------- | ------------- | ------ | :------: |
| tag name | Name next tag | 0.1.0  |   yes    |

### Version

#### Version Major

```{.bash}
task version:major
```

#### Version Minor

```{.bash}
task version:minor
```

#### Version Patch

```{.bash}
task version:patch
```
