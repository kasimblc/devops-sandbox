# DEPLOY - ROLLBACK - ARTIFACT DEPLOYMENT



## 📁 PROJECTS

This repository includes the following projects by **LivaSoft A.Ş.**:

- **SOMEPROJECT**
- **SOMEPROJECT**
- **SOMEPROJECT**
- **SOMEPROJECT**
- **SOMEPROJECT**

Bu proje, PowerShell tabanlı bir CI/CD otomasyon altyapısıdır. Farklı ortamlara (Staging, Production) uygulama dağıtımı, yedekleme, temizlik ve ilk kurulum işlemlerini otomatikleştirir. GitHub Actions ile entegre çalışır.

## CICD Workflow Şeması

```
example-production.yml / example-staging.yml
                │
                ▼
      base-workflow.yml (tetiklenir)
                │
                ▼
      CICD-Controller.ps1 (PowerShell ile çalışır)
                │
                ▼
      scripts klasöründeki modüller:
         ├─ AppPoolManager: IIS havuzunu yönetir
         ├─ BackupManager: Yedekleme ve geri yükleme
         ├─ RemoveManager: Temizlik işlemleri
         ├─ SyncManager: Dosya senkronizasyonu ve dağıtım
         └─ LinuxServiceReset: Linux servislerini yeniden başlatır
```

- Workflow dosyaları ortam ve deploy tipini belirler.
- `example-production.yml / example-staging.yml`, parametreleri alır ve dağıtım sürecini başlatması için `base-workflow.yml` gerekli argümanları vererek çağırır/tetikler.
- `base-workflow.yml`, parametreleri alır ve dağıtım sürecini başlatır.
- `CICD-Controller.ps1`, gelen parametrelere göre ilgili scriptleri tetikler.
- Her script, kendi görevini yerine getirerek dağıtımın tamamlanmasını sağlar.

---

## Workflow Dosyaları ve Parametreler

- **example-production.yml**  
  Production ortamına deploy işlemini tanımlar.

- **example-staging.yml**  
  Staging ortamına deploy işlemini tanımlar.

**Ortak Parametreler:**
- `TARGET_ENV`: Hedef ortam (`production`, `staging`)
- `ACTION`: İşlem tipi (`deploy`, `rollback`, `setup`)
- `DEPLOYTYPE`: Dağıtım tipi (`b2s`, `b2p`, `s2p`)
  - `b2s`: Base'den staging'e
  - `b2p`: Base'den production'a
  - `s2p`: Staging'den production'a
- `TARGET_SERVERS`: Hedef sunucu ID'leri
- `ARGUMENTS_FILE_NAME`: Argüman dosyası adı
- `RUNNER_NAME`: Runner adı

## Dağıtım Argümanları (`arguments.ps1`)

Ortam ve sunucu bazlı dağıtım parametrelerini içerir.

**Değişkenler:**
- `SourcePath`: Kaynak dizin
- `ProjectsRootPath`: Hedef ana dizin
- `ProjectName`: Proje adı/domain
- `Backup`: Yedekleme (`Y`/`N`)
- `SiteCheckMode`: Site kontrol modu (`disable`, `checkonly`, `checkandoffline`)
- `SiteUrl`: Site adresi
- `SleepTime`: Bekleme süresi (sn)

## Özelleştirme

- Firma bazlı ayarlar için `deploy/config/config.ps1` dosyasını düzenleyin. Base yer alan config.ps1 dosyası kullanılır bu dosya ile özel eklenmek istenen konfigrasyonlar base yapıya eklenmesi sağlanır.
- Sunucu ve ortam parametrelerini `deploy/args/arguments.ps1` dosyasından güncelleyin.
---



---
# BASE DEPLOY HAKKINDA GENEL BİLGİ

## 🔗 Related Repository

- [LivasoftConnector/.github-private](https://github.com/LivasoftConnector/.github-private)

### Base Workflow Nedir?

- `base-workflow.yml`, tüm CI/CD işlemlerinin merkezi workflow dosyasıdır.
- Ortam, deploy tipi, sunucu ve argüman parametrelerini alır.
- CICD-Controller.ps1 scriptine ilgili parametreleri verir.
- Esnek ve tekrar kullanılabilir bir altyapı sağlar.

## Klasör Yapısı

- `CICD-Controller.ps1` : Ana kontrol scripti, tüm işlemleri yönetir.
- `config/` : Temel konfigürasyon dosyaları.
- `scripts/` : Yedekleme, senkronizasyon, temizlik ve uygulama havuzu yönetimi için PowerShell sınıfları.
- `shared/` : Ortak kullanılan dosyalar (örn. `app_offline.htm`, `web.config`, `serilog.json`).
- `example-template/` : Örnek template ve workflow dosyaları.

## Temel Bileşenler

- **CICD-Controller.ps1**  
  Dağıtım, rollback ve ilk kurulum işlemlerini parametrelerle yönetir.  
  [CICD-Controller.ps1](CICD-Controller.ps1)

- **Konfigürasyon**  
  Temel ayarlar [config/config_base.ps1](config/config_base.ps1) dosyasında tutulur. Firma bazlı özelleştirme için [example-template/deploy/config/config.ps1](example-template/deploy/config/config.ps1) kullanılır.

- **Workflow Entegrasyonu**  
  GitHub Actions workflow dosyaları ile tetiklenir:  
  - [example-template/.github/workflows/example-production.yml](example-template/.github/workflows/example-production.yml)
  - [example-template/.github/workflows/example-staging.yml](example-template/.github/workflows/example-staging.yml)
  - [base workflow](.github/workflows/base-workflow.yml)

- **Sunucu ve Ortam Tanımları**  
  Dağıtım yapılacak sunucular ve parametreler [example-template/deploy/args/arguments.ps1](example-template/deploy/args/arguments.ps1) dosyasında tanımlanır.

## Script Sınıfları

- [`AppPoolManager`](scripts/AppPool-Manager.ps1) : IIS uygulama havuzunu başlatır/durdurur.
- [`BackupManager`](scripts/Backup-Manager.ps1) : Proje dosyalarını yedekler ve geri yükler.
- [`RemoveManager`](scripts/Remove-Manager.ps1) : Proje klasöründe temizlik işlemlerini yapar.
- [`SyncManager`](scripts/Sync-Manager.ps1) : Dosya senkronizasyonunu ve dağıtımını gerçekleştirir.
- [`LinuxServiceReset`](scripts/LinuxServiceReset.ps1) : Linux sunucularda servisleri SSH ile yeniden başlatır.

## Ortak Dosyalar

- [shared/app_offline.htm](shared/app_offline.htm) : Siteyi offline almak için kullanılır.

### Sadece First-Setup işleminde kopyalanacak dosyalar
- [shared/configFiles/web.config](shared/configFiles/web.config) : Temel web yapılandırması.
- [shared/configFiles/App_Data/serilog.json](shared/configFiles/App_Data/serilog.json) : Serilog log ayarları.

---

