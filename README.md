## 📚 Dokumentasi MinimalUI
Library UI minimalis untuk Roblox dengan animasi dan sistem theme yang mudah dikustomisasi.

---

### 🔧 Instalasi
1. Buat `ScreenGui` di dalam `StarterGui`
2. Tempelkan script berikut sebagai **LocalScript**:

```lua
-- Letakkan kode library di sini
local MinimalUI = { ... }
```

---

### 🎨 Theme Configuration
Konfigurasi warna dan gaya default:

```lua
local Theme = {
    Background = Color3.fromRGB(30, 30, 30),      -- Warna background utama
    LightBackground = Color3.fromRGB(45, 45, 45), -- Warna background sekunder
    Text = Color3.fromRGB(245, 245, 245),         -- Warna teks
    Accent = Color3.fromRGB(0, 170, 255),         -- Warna aksen (button hover, dll)
    CornerRadius = UDim.new(0, 8),                -- Sudut melengkung UI
    StrokeColor = Color3.fromRGB(60, 60, 60)      -- Warna border
}
```

**Cara modifikasi theme:**
```lua
MinimalUI.Theme.Accent = Color3.fromRGB(255, 100, 150)
```

---

### 🖼️ Komponen Utama

#### 1. Window
Membuat window container dengan animasi.

**Method:**
```lua
local window = MinimalUI:Window{
    Title = "Judul Window",
    Size = UDim2.new(0, 300, 0, 400)
}
```

**Fungsi:**
- `window:Open()` - Buka window dengan animasi
- `window:Close()` - Tutup window dengan animasi
- `window:AddElement(guiObject)` - Tambahkan elemen UI ke dalam window

**Contoh:**
```lua
local myWindow = MinimalUI:Window{
    Title = "Inventory",
    Size = UDim2.new(0, 350, 0, 500)
}

myWindow:Open()
```

---

#### 2. Button
Tombol interaktif dengan animasi hover dan klik.

**Method:**
```lua
local button = MinimalUI:Button{
    Text = "Click Me!",
    Callback = function()
        print("Button clicked!")
    end
}
```

**Event:**
```lua
button.MouseButton1Click:Connect(function()
    -- Handle click event
end)
```

**Animasi Otomatis:**
- Hover: Perubahan ukuran dan warna
- Klik: Efek tekan
- Lepas: Efek kembali ke posisi semula

---

### 🌀 Sistem Animasi
Preset animasi yang tersedia:

#### 1. SlideInTop
```lua
Animations.SlideInTop = function(gui)
    gui.Position = UDim2.new(0.5, 0, -0.5, 0)
    return {
        Position = UDim2.new(0.5, 0, 0.5, 0),
        EasingStyle = Enum.EasingStyle.Quad,
        Duration = 0.5
    }
end
```

#### 2. FadeOut
```lua
Animations.FadeOut = function(gui)
    return {
        BackgroundTransparency = 1,
        EasingStyle = Enum.EasingStyle.Quad,
        Duration = 0.3
    }
end
```

**Cara membuat animasi custom:**
```lua
MinimalUI.Animations.CustomAnimation = function(gui)
    return {
        Property = TargetValue,
        EasingStyle = Enum.EasingStyle...,
        Duration = 0.5
    }
end
```

---

### 💻 Contoh Penggunaan
```lua
local UI = MinimalUI.new()

-- Create window
local mainWindow = UI:Window{
    Title = "Main Menu",
    Size = UDim2.new(0, 300, 0, 400)
}

-- Create button
local playButton = UI:Button{
    Text = "Play Game"
}

playButton.MouseButton1Click:Connect(function()
    game:GetService("ReplicatedStorage").StartGame:FireServer()
end)

-- Add components
mainWindow:AddElement(playButton)
mainWindow:Open()
```

---

### 🛠️ Extending Library
Tambahkan komponen custom:

```lua
-- Contoh: Toggle Switch
function MinimalUI:Toggle(config)
    local toggle = self:CreateElement("Frame", {
        Size = UDim2.new(0, 50, 0, 25),
        BackgroundColor3 = Theme.Background
    })
    
    -- Implementasi toggle logic
    return toggle
end
```

---

### 📝 Best Practices
1. Gunakan **Theme** untuk konsistensi warna
2. Manfaatkan method `CreateElement` untuk membuat komponen baru
3. Untuk animasi kompleks, gunakan `TweenService` langsung
4. Atur z-index dengan `ZIndex` property untuk layer management

---

### ⚠️ Troubleshooting
**Masalah**: Animasi tidak bekerja
- Solusi: Pastikan property yang dianimasikan valid (misal: `BackgroundTransparency` bukan `Transparency`)

**Masalah**: UI tidak muncul
- Solusi: Pastikan:
  1. ScreenGui ada di StarterGui
  2. Parent component sudah benar
  3. Visible property di-set ke true
  
