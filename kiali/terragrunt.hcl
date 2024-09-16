include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-kubernetes-kiali.git?ref=v1.0.3"

  after_hook "apply_patch" {
    commands = ["apply"]
    execute  = ["kubectl", "patch", "virtualservice", "kiali", "-n", "istio-system", "--type=json", "-p=[{\"op\": \"add\", \"path\": \"/spec/http/0/headers\", \"value\": {\"request\": {\"set\": {\"X-Forwarded-Port\": \"443\"}}}}]"]
  }
}

inputs = {
  deploy_method                 = "helm"
  helm_custom_values            = true
  helm_custom_values_path       = "kiali.yaml"
  use_openid_connect            = true
  openid_server_pem_certificate = <<EOT
-----BEGIN CERTIFICATE-----
MIIFWDCCA0ACCQC8V/Anc/154TANBgkqhkiG9w0BAQsFADBuMQswCQYDVQQGEwJS
VTEMMAoGA1UECAwDU1BiMQwwCgYDVQQHDANTUGIxEzARBgNVBAoMCkt1YmVybmV0
ZXMxEzARBgNVBAsMCkt1YmVybmV0ZXMxGTAXBgNVBAMMEEt1YmVybmV0ZXNSb290
Q0EwHhcNMjQwODIwMTY0MzM0WhcNMzQwODE4MTY0MzM0WjBuMQswCQYDVQQGEwJS
VTEMMAoGA1UECAwDU1BiMQwwCgYDVQQHDANTUGIxEzARBgNVBAoMCkt1YmVybmV0
ZXMxEzARBgNVBAsMCkt1YmVybmV0ZXMxGTAXBgNVBAMMEEt1YmVybmV0ZXNSb290
Q0EwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDWz7gPxqp1iD38N9Mo
4xn6a/LN8O1VXt1UpO3ft9UvrzCl/q6Dckk64TMxoTMXUoq5tx+fyzDnTb9QuqvZ
XxlGTNttJ8284CAPsBUNDRY+lvckAfE/CkWMIZKbI9eM6XM1DX1i5U6JUN1oz7pu
/YXGHJwHSyZljNg108wsuChsqq0nKDM3i/NmXPsnfZgnNfa6jSzIe7fdtRcbhNBq
eFj7fPx3vn9jlqyS9KM0z/5y6EqOq3EW+7musMl/A1pZnzi1+pBEskbvlvkJ1Ib/
RHMnjDrh+VA8rcmF3KNOzDD9FwAO5Ou/BrNmJf+4+xOAyEZgrgRo1o1QQ0eQzp+D
TXSjV+6H6kJIKmp/X8rqaKlfMHr87C/hhAEgCv2Buk1MK1+WXf2L/tXknQNtIM0e
jRhjYtirac4fpYrKU4hKxj0rk+ikkuh7tnAdM8ZyHZwCYPAeCWsMlyoXJSwL3lcW
JW6xlf36wtayQF3Z/+uJlp5NihnUHbSG06z8bt6ph4AmPpSekB3dEGvPrcZ3pUPQ
6YQZdXzFW4BUFvuNRA+KUuQDdK9pcs1qK4dUBg6bdPxnzhGlkPk4U/kkxMYwofsL
BqP6lKraIDwHl0bZ/84nxmgqJ9izzHG09BzrOgK09E5Ay5Ic+hluiQn849iniMhc
H3BKgaCfATecQus4qRvd2MvY9QIDAQABMA0GCSqGSIb3DQEBCwUAA4ICAQCf2Hoj
cbkc/qG8LVIZwFM3b97wQSj5mfGZNHdplxN35X1PXbKhMKXcpymU7MNDim0qSaCm
lj7GZZLvqr68HDIlVXdYRd0JAySYL2GRIfQg6c+phNJtyMOfuTDvVbi1BICTZc8A
7vRZ+EL87atzGxbyc9+pWe7xIWU2XQwNKeWsRHPH9wZftUEml43yP8WoylcT0OUn
PBLmlqEX/b1mzolJyv1p7lqrCM7Oq6N4ZCusWHsu02hTNhD2m2iP4cAQA0lSeElj
/q8RocBhdX93Ey0GyjS0xZuywK2NBGps7d0zxUfxqhgdPg0oL+50G4TbZvWyO/Bj
YXKXax9LroMfhbB4ZKdl8QqdrXGX26kgSI1I2Ee8vf/XoqzzKWp7GGLLl2wpYQQY
Ic7PsLASPQI7y18GFk++iWghOMXc2m8gkPs6gDBGDgtD06qOpisImdUyG4heB9Xy
q6gMFk8tZ+ADuFW7dsy+g6h1B99v+MJNJlGbpM4omVz6aa692owZ1vj4SgqLHBtJ
qkoTzx3p0szUEvcloV1m0HlBJHPQhl4PuXT7RyFLI/BiawsTe9Qp5nO2lwINaFPT
uGxVOlhUfu8V6GWk34lYUGWsmlozMiS0UTjhpo9RsdrPG4IRUBsqxg504P3HPR1Z
EKaBnDgdju9h1qpL9mFJbVZHFARcaE943jdxxw==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIFYDCCA0gCCQCHYJGxZ0mOnzANBgkqhkiG9w0BAQsFADBuMQswCQYDVQQGEwJS
VTEMMAoGA1UECAwDU1BiMQwwCgYDVQQHDANTUGIxEzARBgNVBAoMCkt1YmVybmV0
ZXMxEzARBgNVBAsMCkt1YmVybmV0ZXMxGTAXBgNVBAMMEEt1YmVybmV0ZXNSb290
Q0EwHhcNMjQwODIwMTY0NDQwWhcNMzQwODE4MTY0NDQwWjB2MQswCQYDVQQGEwJS
VTEMMAoGA1UECAwDU1BiMQwwCgYDVQQHDANTUGIxEzARBgNVBAoMCkt1YmVybmV0
ZXMxEzARBgNVBAsMCkt1YmVybmV0ZXMxITAfBgNVBAMMGEt1YmVybmV0ZXNJbnRl
cm1lZGlhdGVDQTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMr9zfkm
q532MhAt9srXx3i0lBIbvnDgEQbNvDlUdqKGAAtFBOf1xfYHJr1xvUIG4/EOy0Eo
IpVHRMdBMz5mAcfrNS9gFqr9sI9iksx441yZCsGz3GklPRNGzdAcloILRtpLU/dh
s0mSBJyOvWObgiRZI8zLUOkgN7OQAV5yWeBsJt2S1WoFhDiavmWyweo1pBopHxKo
HhOZ4dGyI7EHxsISvxiSLmoZ9u9v0Nxz1v2J1Z4vZP1rTH2ya0in/1PwJqOYGDmc
cZUrv8QCoOpvKXMT73x0spxORHQ6+7M7UYkwYRrApOAJ9xvUYpGYpZwbDbx/Da7n
msbTrUmSlWzCzXAwF7ZzRtpmeWLMSF27IU/kGiVRahEqFMvF29kEegR46RjVqVqW
6UuHY2J7rNA0s+bEt6AwS4btmB+h8qiClCFQ83uGRca13bx0R0cTUZ59s5f2C4IQ
PuHf487ZuCgu/Etf3UzyDuHoZRzKB5ZTkWbJDEjrDIwv7fQDWTAbClyx5tEeZGGI
95bdxp23EUHcFq+QnPurdCi2crJSdkpQk5CLThXkUOtzHLOyZCcm2mRrLVScEmWJ
uUj2Ynng0OEiZP19ZMuXAQ3nFQGY0U2mU+RdmNSwrABJ1ikuoL3IzuuVuIBeiJOs
/idIpUBTflf5KvSt8+KBldcjVmoqoMzcqxy/AgMBAAEwDQYJKoZIhvcNAQELBQAD
ggIBAK2iSgM4qsNdb3EnwTXaNqJH5fTMzVYBQqaDxU88GreALeiWwnGm5dG9WY1l
RAOe+ut+Jdj9/tFT9pv0BJ1NAMYmNkJLun5uHhhsRgxCVgwPWc0ClnffMXru20FY
1ercjxfjL2VrzLtWM46eRP4ezdLKSIRRDtbmtlGmWutxuy/C1KEm1uTTekzynRkt
HBH5V21H6eCwUKxu4IkyCG7FBjBViQQqPINMSPiJ1zpvaUzm8tF9r39mHOsd2Zuh
4Lm1QNk8b/q2KyikizvfKiU8R5SB5Zj6AUUUdl2+fC/AfmkXBhHZdPzuYC5+REb8
8gLj/9MCWamXvS+3lSKSfxqEYtciTgI76zoIG5VZE79KFP4XfOh0C+NYDX8PIhGR
wIElVpVmT5S690UdZJxWWW2iPeD5o1atBPx2chnD+RcWeKeuxfZEzLnjCT1I7Zhx
cglPswY0/WLK23ISPCpPMdNokiR6YFllsSVBC1uDMgHxFPKhwik+mIPeMZmqhBG4
y+jR+MY6GDtE0blotFgR4GPn3i6GvLCAbtqr8e7E1LLLtar4g6wYBvCfkT3NZFtk
jGGoTo/mNRnsLcRKuH0/p+2kNuhc+JZ2uCJRKqbEMeOKIatqaWfUR55diIeGYFLF
tf1QiObtmvr1jxIF6pHPd3IZuzfAMmmndKXH3+WrDuhYYef+
-----END CERTIFICATE-----
EOT
  openid_secret                 = "OQm4c...vAkYN"
}

generate "module" {
  path      = "network.tf"
  if_exists = "overwrite"
  contents  = <<EOF

module "istio-network" {
  source = "github.com/Puhhh/terraform-istio-network"

  tls-name                       = "kiali"
  server-url                     = "kiali.kubernetes.local"
  tls-certificate-files          = true
  tls-crt                        = "LS0tL...tLQo="
  tls-key                        = "LS0tL...tLS0K"
  server-svc-name                = "kiali"
  server-svc-namemespace         = "istio-system"
  destination-port               = 20001
}
EOF
}
