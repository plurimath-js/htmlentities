class HTMLEntities
  FLAVORS            = %w[html4 xhtml1 expanded]
  MAPPINGS           = {} unless defined? MAPPINGS
  SKIP_DUP_ENCODINGS = {} unless defined? SKIP_DUP_ENCODINGS
end

require "htmlentities/mappings/html4"
require "htmlentities/mappings/xhtml1"
require "htmlentities/mappings/expanded"
