require File.expand_path('../../../util/ini_file', __FILE__)

Puppet::Type.type(:ini_setting).provide(:ruby) do

  def exists?
    ini_file.get_value(resource[:section], resource[:setting]) == resource[:value].to_s
  end

  def create
    ini_file.set_value(resource[:section], resource[:setting], resource[:value])
    ini_file.save
    @ini_file = nil
  end

  def value
    ini_file.get_value(resource[:section], resource[:setting]) == resource[:value].to_s
  end

  def value=(value)
    ini_file.set_value(resource[:section], resource[:setting], resource[:value])
    ini_file.save
  end

  def file_path
    resource[:path]
  end


  private
  def ini_file
    @ini_file ||= Puppet::Util::IniFile.new(file_path)
  end
end
