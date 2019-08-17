module Concerns::Findable

  def find_by_name(name)
    self.all.select { |t| t.name == name }.first
  end

  def find_or_create_by_name(name)
    find_by_name(name) != nil ? find_by_name(name) : self.create(name)
  end
end
