import { Actions, PlopGeneratorConfig } from 'node-plop'
import slugify from 'slugify'
import * as path from 'path'
import { baseGeneratorPath, baseTemplatesPath, pathExists, pathMake } from '../utils'

export enum TestPrompNames {
  'testName' = 'testName'
}

type Answers = { [P in TestPrompNames]: string }

const testPath = path.join(baseGeneratorPath, 'test')

export const testGenerator: PlopGeneratorConfig = {
  description: 'add an path to test',
  prompts: [
    {
      type: 'input',
      name: TestPrompNames.testName,
      message: 'What should it be test?',
      default: 'basic'
    }
  ],
  actions: (data) => {
    const answers = data as Answers
    const containerPath = `${testPath}/openvpn-${slugify(answers.testName, '-')}`

    if (!pathExists(containerPath)) {
      pathMake(containerPath)
    }

    const actions: Actions = []

    actions.push({
      type: 'add',
      templateFile: `${baseTemplatesPath}/test.add.hbs`,
      path: `${testPath}/aws_openvpn_${slugify(answers.testName, '_')}_test.go`,
      abortOnFail: true
    })

    actions.push({
      type: 'add',
      templateFile: `${baseTemplatesPath}/test/main.add.hbs`,
      path: `${containerPath}/main.tf`,
      abortOnFail: false
    })

    actions.push({
      type: 'add',
      templateFile: `${baseTemplatesPath}/test/outputs.add.hbs`,
      path: `${containerPath}/outputs.tf`,
      abortOnFail: true
    })

    actions.push({
      type: 'add',
      templateFile: `${baseTemplatesPath}/test/provider.add.hbs`,
      path: `${containerPath}/provider.tf`,
      abortOnFail: true
    })

    actions.push({
      type: 'add',
      templateFile: `${baseTemplatesPath}/test/variables.add.hbs`,
      path: `${containerPath}/variables.tf`,
      abortOnFail: true
    })

    actions.push({
      type: 'add',
      templateFile: `${baseTemplatesPath}/test/versions.add.hbs`,
      path: `${containerPath}/versions.tf`,
      abortOnFail: true
    })

    return actions
  }
}
