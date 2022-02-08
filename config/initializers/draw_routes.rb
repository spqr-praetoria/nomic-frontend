# frozen_string_literal: true

class ActionDispatch::Routing::Mapper
  def draw(route_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{route_name}.rb")))
  end
end
