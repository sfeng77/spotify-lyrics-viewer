$cert = New-SelfSignedCertificate -DnsName "localhost" -CertStoreLocation "cert:\LocalMachine\My" -NotAfter (Get-Date).AddYears(1)
$pwd = ConvertTo-SecureString -String "password" -Force -AsPlainText
$path = "cert:\LocalMachine\My\$($cert.thumbprint)"
$certPath = "server.cert"
$keyPath = "server.key"

Export-Certificate -Cert $cert -FilePath $certPath
$pkeyxml = [System.Security.Cryptography.X509Certificates.RSACertificateExtensions]::GetRSAPrivateKey($cert).ToXmlString($true)
[System.IO.File]::WriteAllText($keyPath, $pkeyxml) 