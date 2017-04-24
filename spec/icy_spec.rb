RSpec.describe Icy do
  describe 'require_tree' do
    it 'requires descendant ".rb" files' do
      expect { Support::ModuleA::ModuleB::ClassA }.to raise_error NameError

      Icy.require_tree 'support/module_a'

      expect(Support::ModuleA::ClassA).to be_a Class
      expect(Support::ModuleA::ModuleB::ClassB).to be_a Class
    end

    it 'accepts absolute paths' do
      Icy.require_tree "#{__dir__}/support/module_c"

      expect(Support::ModuleC::ModuleD::ClassC).to be_a Class
    end

    it 'can exclude directories and files' do
      Icy.require_tree 'support/module_e', exclude: ['support/module_e/module_f', 'support/module_e/class_f.rb']

      expect { Support::ModuleE::ModuleF::ClassD }.to raise_error NameError
      expect { Support::ModuleE::ClassF }.to raise_error NameError
      expect(Support::ModuleE::ClassE).to be_a Class
    end
  end
end
