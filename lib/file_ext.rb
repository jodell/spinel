
# Core extension:
# Shortcut to a full file path
# ala: require File.pwd + '/some/other/file'
# Fixed naive, untested version per dradcliffe. Thanks!
# jodell
 
class File
  def self.pwd
    self.expand_path(self.dirname(caller.first.split(':').first))
  end
end
