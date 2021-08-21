# frozen_string_literal: true

workspace do
  api = nil
  database = nil

  model do
    system = software_system "Software System" do
      database = container "Database"

      api = container "Service API"
      api.point_to database, label: "Uses"
    end

    deployment_environment "Example 1" do
      deployment_node "Server 1" do
        container_instance api
        container_instance database
      end
      deployment_node "Server 2" do
        container_instance api
        container_instance database
      end
    end

    deployment_environment "Example 2" do
      service_instance1 = deployment_group "Service Instance 1"
      service_instance2 = deployment_group "Service Instance 2"

      deployment_node "Server 1" do
        container_instance api, service_instance1
        container_instance database, service_instance1
      end

      deployment_node "Server 2" do
        container_instance api, service_instance2
        container_instance database, service_instance2
      end
    end
  end

  views do |view|
    deployment :all, "Example 1" do |deploy|
      deploy.includes :all
      deploy.auto_layout
    end

    deployment :all, "Example 2" do |deploy|
      deploy.includes :all
      deploy.auto_layout
    end

    view.theme :default
  end
end
