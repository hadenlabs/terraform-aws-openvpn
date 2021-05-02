import * as path from 'path'
import fs from 'fs'

export const baseGeneratorPath = path.join(__dirname, '../../../../')
export const baseTemplatesPath = path.join(__dirname, '../templates')

export const cleanString = (text: string): string => {
  return text.replace(/[.-_]+/g, ' ').toLowerCase()
}

export const hyphenate = (text: string): string => {
  return text.replace(/([a-zA-Z])(?=[A-Z])/g, '$1-').toLowerCase()
}

export function pathExists(path: string): boolean {
  return fs.existsSync(path)
}

export function pathMake(path: string): void {
  return fs.mkdirSync(path)
}
