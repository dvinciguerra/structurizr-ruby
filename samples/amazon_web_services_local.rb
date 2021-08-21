# frozen_string_literal: true
#
workspace "Amazon Web Services Example" "An example AWS deployment architecture." do
  identifiers! :hierarchical

  model do
    spring_pet_clinic = software_system "Spring PetClinic" "Allows employees to view and manage information regarding the veterinarians, the clients, and their pets.", "Spring Boot Application" do
      web_application = container "Web Application", "Allows employees to view and manage information regarding the veterinarians, the clients, and their pets.", "Java and Spring Boot"
      database = container "Database", "Stores information regarding the veterinarians, the clients, and their pets.", "Relational database schema", "Database"

      web_application.point_to database, label: "Reads from and writes to" "JDBC/SSL"
    end

    live = deployment_environment "Live" do
      aws = deployment_node "Amazon Web Services", "", "", "Amazon Web Services - Cloud" do
        region = deployment_node "US-East-1", "", "", "Amazon Web Services - Region" do
          route53 = infrastructure_node "Route 53", "", "", "Amazon Web Services - Route 53"
          elb = infrastructure_node "Elastic Load Balancer", "", "", "Amazon Web Services - Elastic Load Balancing"

          autoscaling_group = deployment_node "Autoscaling group", "", "", "Amazon Web Services - Auto Scaling" do
            ec2 = deployment_node "Amazon EC2", "", "", "Amazon Web Services - EC2" do
              web_application_instance = container_instance spring_pet_clinic.linked(:web_application)
              elb.point_to web_application_instance, label "Forwards requests to", "HTTPS"
            end
          end

          rds = deployment_node "Amazon RDS", "", "", "Amazon Web Services - RDS" do
            mysql = deployment_node "MySQL", "", "", "Amazon Web Services - RDS MySQL instance" do
              database_instance = container_instance spring_pet_clinic.at(:database)
            end
          end

          route53.point_to elb, label: "Forwards requests to", "HTTPS"
        end
      end
    end
  end

  views do |view|
    deployment spring_pet_clinic "Live", "AmazonWebServicesDeployment" do |context|
      context.include :all
      context.auto_layout :lr

      animation do
        # live.aws.region.route53
        # live.aws.region.elb
        # live.aws.region.autoscaling_group.ec2.web_application_instance
        # live.aws.region.rds.mysql.database_instance
      end
    end

    styles do
      element "Element" do |e|
        e.shape :roundedbox
        e.background "#ffffff"
      end

      element "Database" do |e|
        e.shape :cylinder
      end

      element "Infrastructure Node" do |e|
        e.shape :roundedbox
      end
    end

    view.themes "https://static.structurizr.com/themes/amazon-web-services-2020.04.30/theme.json"
  end
end
