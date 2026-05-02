# Session Log

## 2026-04-09

### Запрос
Миграция стека окружения NixOS + home-manager (aarch64-linux, nixos-25.11, compositor = niri):
- Заменить waybar → Noctalia
- Передать управление обоями (swaybg/stylix.image) → Noctalia
- Переключить блокировку экрана (swaylock + swayidle) → Noctalia lockscreen
- Добавить уведомления через Noctalia

### Действия

| Файл | Действие | Детали |
|---|---|---|
| `flake.nix` | Добавлен input | `noctalia.url = "github:noctalia-dev/noctalia-shell"` |
| `flake.nix` | Добавлен cachix | `https://noctalia.cachix.org` + public key |
| `flake.nix` | Без изменений | `extraSpecialArgs` уже содержал `inputs` |
| `home-manager/modules/noctalia.nix` | Создан | Новый модуль: compositor=niri, wallpapers eDP-1, lockscreen.enable=true, systemd.enable=true |
| `home-manager/modules/stylix.nix` | Удалена строка | `image = ../wallpaper.png;` |
| `home-manager/modules/niri.nix` | Удалены spawn-at-startup | `waybar`, `swaybg`, `swayidle` |
| `home-manager/modules/niri.nix` | Удалён keybind | `Mod+Shift+W` (pkill -SIGUSR1 waybar) |
| `home-manager/modules/niri.nix` | Заменён keybind | `Mod+Shift+L` → `noctalia-shell ipc call lockscreen lock` |
| `home-manager/home-packages.nix` | Удалены пакеты | `swaybg`, `swaylock`, `swayidle` |
| `home-manager/modules/default.nix` | Закомментирован импорт | `# ./waybar` |
| `home-manager/modules/default.nix` | Добавлен импорт | `./noctalia.nix` |
| `home-manager/home.nix` | Удалена строка | `file.".local/share/wallpaper.png".source = ./wallpaper.png;` |

### Результат
Все 7 шагов выполнены. `home-manager switch` не запускался.

### Предупреждения
- Репозиторий `noctalia-dev/noctalia-shell` не проверялся на существование (нет доступа к сети).
- API модуля (`homeModules.default`, `programs.noctalia-shell`, `settings.wallpapers`, `ipc call lockscreen lock`) взят из задания — нужно верифицировать по реальной документации перед применением.

---

### Запрос
Создать `/home/timon/memory.md` — лог запросов, действий, результатов.

### Действия
- Создан `/home/timon/memory.md` с логом текущей сессии.

### Результат
Файл создан.

---

## 2026-04-22

### Запрос
1. Откатить noctalia полностью (не понравилось)
2. Добавить поддержку двух внешних мониторов через DisplayLink-адаптер
3. Настроить воркспейсы в niri: мониторы 1-3 → DL-1 (1080p), 4-10 → DL-2 (1440p), 11+ → eDP-1 (ноутбук)
4. Правила окон: obsidian→ws1, caido→ws2, helix→ws3 (не реализуемо через window-rule — запускается в терминале), firefox→ws4, telegram→ws5, vesktop→ws6
5. `hms` по завершении

### Действия

| Файл | Действие | Детали |
|---|---|---|
| `flake.nix` | Удалён input | `noctalia` |
| `flake.nix` | Удалён cachix | `noctalia.cachix.org` + public key |
| `home-manager/modules/default.nix` | Восстановлен импорт | `./waybar` (был закомментирован) |
| `home-manager/modules/default.nix` | Удалён импорт | `./noctalia.nix` |
| `home-manager/modules/noctalia.nix` | Удалён файл | — |
| `home-manager/modules/stylix.nix` | Восстановлена строка | `image = ../wallpaper.png;` |
| `home-manager/modules/niri.nix` | Восстановлены spawn-at-startup | `waybar`, `swaybg`, `swayidle` |
| `home-manager/modules/niri.nix` | Восстановлен keybind | `Mod+Shift+W` (pkill -SIGUSR1 waybar) |
| `home-manager/modules/niri.nix` | Восстановлен keybind | `Mod+Shift+L` → `swaylock -f -c 000000` |
| `home-manager/modules/niri.nix` | Добавлены output блоки | `DL-1` (1920×1080@60), `DL-2` (2560×1440@60) |
| `home-manager/modules/niri.nix` | Добавлены workspace блоки | ws 1-3 → DL-1, 4-10 → DL-2, 11-14 → eDP-1 |
| `home-manager/modules/niri.nix` | Обновлены window-rule | obsidian→ws1, caido→ws2, firefox→ws4, telegram→ws5, vesktop→ws6 |
| `home-manager/modules/niri.nix` | Обновлены keybinds | `focus-workspace "N"` / `move-column-to-workspace "N"` (строковые имена) |
| `home-manager/modules/niri.nix` | Добавлены keybinds | `Mod+0`→ws10, `Mod+Shift+1-3`→ws11-13, `Mod+Ctrl+0`, `Mod+Ctrl+Shift+1-3` |
| `home-manager/home-packages.nix` | Восстановлены пакеты | `swaybg`, `swaylock`, `swayidle` |
| `home-manager/home.nix` | Восстановлена строка | `file.".local/share/wallpaper.png".source = ./wallpaper.png;` |
| `hosts/macbook-m2/local-packages.nix` | Добавлено | `hardware.displaylink.enable = true` |

### Результат
`hms` прошёл успешно. `sw` (nixos-rebuild) не запускался — требует sudo, пользователь запускает вручную.

### Важные заметки
- Имена выходов DisplayLink **неизвестны** до подключения. В конфиге стоят плейсхолдеры `DL-1` / `DL-2`. После `sw` и подключения мониторов нужно запустить `niri msg outputs` и обновить имена в `home-manager/modules/niri.nix`.
- `focus-workspace-name` и `move-column-to-workspace-name` **не существуют** в niri v25.08. Для именованных воркспейсов используется `focus-workspace "name"` (строка в кавычках).
- `Mod+Shift+4-6` заняты скриншотами — поэтому ws 11-13 на `Mod+Shift+1-3`, ws14+ доступны через `Mod+J/K`.
- helix запускается в терминале, window-rule по app-id не применима.

### Правка 2026-04-22 (после основной сессии)
- `home-manager/modules/niri.nix`: ws3 — исправлено с helix на ghostty (`app-id = "com.mitchellh.ghostty"`). hms не запускался.

### Правка 2026-04-22 (sw — ошибка сборки)
- `hosts/macbook-m2/local-packages.nix`: удалён `hardware.displaylink.enable = true` — опция не существует в nixpkgs (nixos-25.11). `hardware.displaylink` не является стандартным NixOS модулем.

---

## 2026-04-23

### Диагноз: краш niri при логине + мигание мониторов

**Симптом 1:** После sw и ребута — ввод пароля, мелькнул wallpaper + hotkey overlay niri, вылет обратно на логин. Второй вход — чёрный экран.

**Причина:** smiusbdisplay ждал niri socket (появляется сразу при старте niri), запускал `modprobe evdi`, evdi-устройство появлялось через ~1 сек после старта niri. niri получал udev-событие о новом DRM-устройстве, пытался добавить второй render node — panic на assertion `dmabuf_global.replace(...).is_none()`.

**Фикс:** `nixos/modules/smi-usb-display.nix` — evdi перенесён в `boot.kernelModules`, убран `modprobe evdi` из `ExecStartPre`. Устройство появляется до greetd, niri видит его при старте и пропускает gracefully (`Operation not supported`).

**Симптом 2:** Мигание мониторов после sw.

**Причина:** evdi vermagic mismatch (`6.19.9 SMP preempt` vs `6.19.9 SMP`) — smiusbdisplay падает и рестартует каждые 5 секунд, каждый раз генерируя USB-события. Несмотря на то что sw принёс ядро 6.19.11 (`current-system` → 6.19.11), после ребута загрузился старый образ 6.19.9 (`booted-system` → 6.19.9).

**Решение:** повторный ребут — загрузчик возьмёт 6.19.11, vermagic совпадёт, evdi загрузится.

---

## 2026-04-27

### Запрос
При загрузке в 6.19.11 — чёрный экран (niri паника при DRM hotplug от evdi, загруженного до display-manager). Пользователь намеренно возвращался на 6.19.9 чтобы иметь доступ к системе. Цель: убрать причину чёрного экрана и сделать SMI on-demand — не запускать при загрузке, только при физическом подключении. После подключения автоматически перезагружать конфиг niri без ребута.

### Действия

| Файл | Действие | Детали |
|---|---|---|
| `nixos/modules/smi-usb-display.nix` | Изменён | Убран `boot.kernelModules = ["evdi"]` и `before`/`wantedBy` — сервис больше не стартует при загрузке |
| `nixos/modules/smi-usb-display.nix` | Изменён | `modprobe evdi` перенесён в startScript; после поднятия дисплея пишется `/run/smi-display-ready`; `ExecStopPost` удаляет его |
| `nixos/modules/smi-usb-display.nix` | Изменён | `Restart = "no"` — рестарт только через udev; udev rules добавлены `systemctl start/stop smiusbdisplay.service` |
| `nixos/modules/smi-usb-display.nix` | Удалено | Зависимость `display-manager.service` от `smiusbdisplay.service` |
| `home-manager/modules/niri-smi-hotplug.nix` | Создан | systemd user path unit следит за `/run/smi-display-ready`; при появлении файла — `niri msg action reload-config` |
| `home-manager/modules/default.nix` | Добавлен импорт | `./niri-smi-hotplug.nix` |

### Логика работы
- **Без SMI устройства:** evdi не грузится, smiusbdisplay не запускается, niri стартует только с eDP-1. Воркспейсы 1-10 (DL-1/DL-2) временно падают на eDP-1.
- **При подключении устройства:** udev → `systemctl start smiusbdisplay` → `modprobe evdi` → SMIUSBDisplayManager → DRM outputs появляются → `/run/smi-display-ready` создаётся → path unit → `niri msg action reload-config` → воркспейсы перераспределяются на DL-1/DL-2.
- **При отключении:** udev → `systemctl stop smiusbdisplay` → `ExecStopPost` удаляет флаг → niri замечает DRM hotunplug и перемещает окна на eDP-1.

### Важные заметки
- Имена выходов DL-1/DL-2 в niri.nix — плейсхолдеры. После первого подключения запустить `niri msg outputs` и обновить имена.
- Убрав evdi из boot.kernelModules и smiusbdisplay из before/wantedBy — должен исчезнуть чёрный экран на 6.19.11.
- sw и hms прошли успешно. `niri-smi-hotplug.path` запущен.
- **Итог:** после ребута в 6.19.11 и подключения адаптера — чёрный экран снова. Диагностика в сессии 2026-04-27 #3.

---

## 2026-04-27 #3

### Симптом
После hms и ребута в 6.19.11 — подключение адаптера → чёрный экран снова. render-drm-device фикс, возможно, не сработал или есть новая причина.

### Диагностика (начата)
Запрошены логи: `journalctl --boot -1 -p 4 | grep -i "niri\|evdi\|smi\|drm"` и `journalctl --boot -1 _COMM=niri | tail -30`.

---

## 2026-04-27 #4

### Симптом
После применения `render-drm-device "/dev/dri/renderD128"` через hms — паника niri сохраняется. Подключение SMI адаптера → вылет на логин-экран.

### Диагноз
`render-drm-device` меняет render node для рендеринга, но **не** исправляет `device_added`. В niri 25.08 `tty.rs:525`:
```rust
if node == self.primary_node || render_node == self.primary_render_node {
    // ...
    assert!(self.dmabuf_global.replace(dmabuf_global).is_none()); // line 572
}
```
- DCP (card2): `try_get_render_node()` → renderD128 → `is_primary=true` → dmabuf_global set
- evdi (card0/card3): `try_get_render_node()` → renderD128 → `is_primary=true` → PANIC

Оба устройства получают renderD128 через EGL и попадают в блок. assert на второй вызов.

### Фикс (backport из niri-unstable 2026-03-10)
В niri-unstable `tty.rs:802`:
```rust
if render_node == Some(self.primary_render_node) && self.dmabuf_global.is_none() {
```
Добавлен `&& self.dmabuf_global.is_none()` — dmabuf_global инициализируется только ОДИН раз (первым устройством), последующие пропускаются.

### Действия

| Файл | Действие | Детали |
|---|---|---|
| `patches/niri-dmabuf-fix.patch` | Создан | Однострочный backport: `tty.rs:525` добавлен `&& self.dmabuf_global.is_none()` |
| `home-manager/modules/niri.nix` | Изменён | `programs.niri.package = pkgs.niri-stable.override { patches = [ ./patches/niri-dmabuf-fix.patch ]; }` |

### Статус
hms применён 2026-04-28. Патченый niri собран и установлен.

### После сборки
Проверить подключение SMI адаптера — паника должна исчезнуть. Внешние мониторы должны появиться как DVI-I-1/DVI-I-2 в niri.
