# gcp_cloud_iap_test
Cloud IAP設定を試す

# 構成

- VPC Network
    - Subnetwork (asia-northeast1)
- Compute Engine VM Instance
    - FWルールで Cloud IAP のCIDR `35.235.240.0/20` からのSSH/RDPを許可

# デプロイ

- サービスアカウントキーを作成する。 
    - `gcp_terraform/gcp-bigip-test-terraform-account.json`
- Cloud Storageバケットを作成する
    - `cloudiap-test-tfstate-kuvd6hgnbr`
- 以下コマンドを実行
    - `terraform plan`
    - `terraform apply`