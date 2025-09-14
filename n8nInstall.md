````markdown
# n8n Kurulum Rehberi (PostgreSQL + Node.js v22 + Basic Auth)

Bu rehber, Docker ve Nginx kullanmadan n8n'i PostgreSQL ile çalışacak şekilde kurmak için hazırlanmıştır.  

---

## 1. Node.js v22 Kurulumu

```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs
````

Kurulum kontrolü:

```bash
node -v
npm -v
```

---

## 2. n8n Kurulumu

```bash
sudo npm install -g n8n
```

---

## 3. n8n Kullanıcısı Oluşturma

```bash
sudo useradd -m -s /bin/bash n8n
sudo usermod -aG sudo n8n
```

---

## 4. n8n Veri Dizini ve İzinler

```bash
sudo mkdir -p /home/n8n/.n8n
sudo chown -R n8n:n8n /home/n8n/.n8n
```

---

## 5. .env Dosyasını Oluşturma

```bash
sudo nano /home/n8n/.n8n/.env
```

İçerik:

```env
# Veritabanı Ayarları (PostgreSQL)
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=localhost
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=n8n
DB_POSTGRESDB_USER=n8n_user
DB_POSTGRESDB_PASSWORD=supersecret

# n8n Servis Ayarları
N8N_HOST=0.0.0.0
N8N_PORT=5678

# Performans Ayarları
N8N_DEFAULT_BINARY_DATA_MODE=filesystem
N8N_DEFAULT_LOCALE=en
EXECUTIONS_DATA_PRUNE=true
EXECUTIONS_DATA_MAX_AGE=168

# Geliştirme Ayarları
N8N_LOG_LEVEL=info
N8N_METRICS=true

# Basic Auth (Web Arayüzü Güvenliği)
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=adminuser
N8N_BASIC_AUTH_PASSWORD=supersecretpassword
```

> Kullanıcı adı ve şifreyi kendi istediğiniz şekilde değiştirebilirsiniz.

---

## 6. n8n’i Başlatma

```bash
sudo -u n8n n8n start --env /home/n8n/.n8n/.env
```

Tarayıcıda: `http://<sunucu-ip>:5678`

* Basic Auth aktif olduğundan girişte kullanıcı adı ve şifre sorulur.

---

## 7. Systemd Servisi Oluşturma (Opsiyonel)

```bash
sudo nano /etc/systemd/system/n8n.service
```

İçerik:

```ini
[Unit]
Description=n8n Workflow Automation
After=network.target

[Service]
Type=simple
User=n8n
ExecStart=/usr/local/bin/n8n start --env /home/n8n/.n8n/.env
Restart=always
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
```

Servisi etkinleştir ve başlat:

```bash
sudo systemctl daemon-reload
sudo systemctl enable n8n
sudo systemctl start n8n
```

---

## 8. Firewall / Port Açma

```bash
sudo ufw allow 5678/tcp
sudo ufw reload
```

---

Artık n8n, **PostgreSQL ile veritabanı kullanarak**, **Node.js v22** ile çalışıyor ve **Basic Auth** ile web arayüzü korunuyor.

```

---

İstersen ben bunu bir adım daha ileri götürüp **Traefik üzerinden dışarı açma ve HTTPS** ile erişim rehberi olarak da Markdown hazırlayabilirim. Bunu da yapayım mı?
```
