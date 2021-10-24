vim.g.projectionist_heuristics = {
  ['*.go'] = {
    ['*.go'] = { alternate = '{}_test.go', ['type'] = 'source' },
    ['*_test.go'] = { alternate = '{}.go', ['type'] = 'test' },
  },
  ['lib/*.dart'] = {
    ['lib/screens/*.dart'] = {
      alternate = 'lib/view_models/{}_view_model.dart',
      type = 'view',
    },
    ['lib/view_models/*_view_model.dart'] = {
      alternate = { 'lib/screens/{}.dart', 'lib/widgets/{}.dart' },
      type = 'model',
      template = { 'class {camelcase|capitalize}ViewModel extends BaseViewModel {', '}' },
    },
    ['test/view_models/*_view_model_test.dart'] = {
      alternate = 'lib/view_models/{}_view_model.dart',
      type = 'test',
      template = {
        "import 'package:test/test.dart';",
        '',
        'void main() async {',
        "  group('TODO', () {",
        '    // TODO:',
        '  })',
        '}',
      },
    },
    ['test/services/*_test.dart'] = {
      alternate = 'lib/services/{}.dart',
      type = 'test',
      template = {
        "import 'package:test/test.dart';",
        '',
        'void main() async {',
        "  group('TODO', () {",
        '    // TODO:',
        '  })',
        '}',
      },
    },
    ['test/widget/*_test.dart'] = {
      alternate = 'lib/screens/{}.dart',
      type = 'test',
      template = {
        "import 'package:test/test.dart';",
        '',
        'void main() async {',
        "  group('TODO', () {",
        '    // TODO:',
        '  })',
        '}',
      },
    },
  },
}

global.map('n', '<Leader>A', '<cmd>A<CR>')
global.map('n', '<Leader>av', '<cmd>AV<CR>')
global.map('n', '<Leader>at', '<cmd>Vtest<CR>')
