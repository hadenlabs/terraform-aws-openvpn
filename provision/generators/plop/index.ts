import { NodePlopAPI } from 'node-plop'
import { testGenerator } from './generators'

export default function plop(plop: NodePlopAPI): void {
  plop.setGenerator('test', testGenerator)
}
