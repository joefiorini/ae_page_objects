require 'capybara'
require 'capybara/dsl'
require 'active_support'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/object/try'
require 'active_support/core_ext/class'
require 'active_support/dependencies'

module AePageObjects
  autoload :ConstantResolver,     'ae_page_objects/core/constant_resolver'
  autoload :DependenciesHook,     'ae_page_objects/core/dependencies_hook'
  autoload :Installable,          'ae_page_objects/core/installable'
  autoload :Configuration,        'ae_page_objects/core/configuration'
  autoload :Configurable,         'ae_page_objects/core/configurable'
  autoload :Application,          'ae_page_objects/core/application'
  autoload :ApplicationRouter,    'ae_page_objects/core/application_router'
  autoload :RakeRouter,           'ae_page_objects/core/rake_router'
  autoload :InternalHelpers,      'ae_page_objects/core/internal_helpers'
  
  module AttributeMethods
    autoload :NodeAccessor,       'ae_page_objects/core/attribute_methods/node_accessor'
    autoload :Node,               'ae_page_objects/core/attribute_methods/node'
    autoload :NestedNode,         'ae_page_objects/core/attribute_methods/nested_node'
    autoload :Nodes,              'ae_page_objects/core/attribute_methods/nodes'
  end
  
  autoload :FormDsl,              'ae_page_objects/core/form_dsl'

  module Methods
    autoload :Node, 'ae_page_objects/methods/node'
  end
  
  autoload :Node,              'ae_page_objects/node'
  autoload :Document,          'ae_page_objects/document'
  autoload :Element,           'ae_page_objects/element'
  autoload :ElementProxy,      'ae_page_objects/element_proxy'
  autoload :HasOne,            'ae_page_objects/has_one'
  autoload :Collection,        'ae_page_objects/collection'
  autoload :Form,              'ae_page_objects/form'
  autoload :Select,            'ae_page_objects/select'
  autoload :Checkbox,          'ae_page_objects/checkbox'
  
  autoload :LoadEnsuring,     'ae_page_objects/load_ensuring'
  autoload :Staleable,        'ae_page_objects/staleable'
  autoload :Visitable,        'ae_page_objects/visitable'
end

ActiveSupport::Dependencies.extend AePageObjects::DependenciesHook









