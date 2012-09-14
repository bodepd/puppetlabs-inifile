Puppet::Type.newtype(:ini_setting) do

  ensurable do
    defaultvalues
    defaultto :present
  end

  def self.title_patterns
    identity = lambda {|x| x}
    [
      [/\A(\[(\S+)\]\/(\S+)\/(\S+))\Z/m,
        [[:name,    identity],
         [:file,    identity],
         [:section, identity],
         [:setting, identity]]],
      [/\A((\S+)\/(\S+))\Z/m,
        [[:name,    identity],
         [:section, identity],
         [:setting, identity]]],
    ]
  end

  newparam(:name, :namevar => true) do
  end

  newparam(:section) do
    desc 'The name of the section in the ini file in which the setting should be defined.'
  end

  newparam(:setting) do
    desc 'The name of the setting to be defined.'
  end

  newparam(:path) do
    desc 'The ini file Puppet will ensure contains the specified setting.'
    validate do |value|
      unless (Puppet.features.posix? and value =~ /^\//) or (Puppet.features.microsoft_windows? and (value =~ /^.:\// or value =~ /^\/\/[^\/]+\/[^\/]+/))
        raise(Puppet::Error, "File paths must be fully qualified, not '#{value}'")
      end
    end
  end

  newproperty(:value) do
    desc 'The value of the setting to be defined.'
  end


end
