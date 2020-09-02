source "azure-arm" "packer-demo" {
    subscription_id = "xxxxxx-xxxxx-xxxx-xxxx-xxxxxxx"
    client_id = "xxxxxx-xxxxx-xxxx-xxxx-xxxxxxx"
    client_secret = "xxxxxx-xxxxx-xxxx-xxxx-xxxxxxx"
    tenant_id = "xxxxxx-xxxxx-xxxx-xxxx-xxxxxxx"
    location = "southeastasia"
    vm_size = "standard_DS3_v2"
    os_type = "linux"

    shared_image_gallery {
        subscription = "xxxxxx-xxxxx-xxxx-xxxx-xxxxxxx"
        resource_group = "dev-rg-01"
        gallery_name = "base01"
        image_name = "base-app-01"
        image_version = "0.0.1"
    }

    managed_image_name = "image-app-02"
    managed_image_resource_group_name = "dev-rg-01"
    shared_image_gallery_destination  {
        resource_group = "dev-rg-01"
        gallery_name = "readytodeploy01"
        image_name = "app01"
        image_version = "1.0.0"
        replication_regions = [ "southeastasia"]
    }
}

build {
  sources = [ "source.azure-arm.packer-demo" ]
  provisioner "shell" {
    inline = [
        "sudo yum install -y httpd",
        "sudo service httpd start",
        ]
  }

}
