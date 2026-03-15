import AppKit
import SwiftUI

// MARK: - App Entry

let app = NSApplication.shared
let controller = StatusBarController()
app.run()

// MARK: - Status Bar Controller

class StatusBarController {
    private let toggle: NSStatusItem
    private let separator: NSStatusItem
    private let menu = NSMenu()
    private var collapsed = false
    private var timer: Timer?
    private var monitor: Any?
    private var prefsWindow: NSWindow?

    init() {
        toggle = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        separator = NSStatusBar.system.statusItem(withLength: 1)
        toggle.autosaveName = "FoldBar_Toggle"
        separator.autosaveName = "FoldBar_Separator"

        // Toggle button
        toggle.button?.title = "◀"
        toggle.button?.font = .systemFont(ofSize: 10)
        toggle.button?.target = self
        toggle.button?.action = #selector(clicked)
        toggle.button?.sendAction(on: [.leftMouseUp, .rightMouseUp])

        // Separator
        separator.button?.title = "┃"
        separator.button?.font = .systemFont(ofSize: 10)

        // Right-click menu
        let prefsItem = NSMenuItem(title: "设置...", action: #selector(showPrefs), keyEquivalent: ",")
        prefsItem.target = self
        let quitItem = NSMenuItem(title: "退出 FoldBar", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        menu.addItem(prefsItem)
        menu.addItem(.separator())
        menu.addItem(quitItem)

        // First launch guide
        if !UserDefaults.standard.bool(forKey: "launched") {
            UserDefaults.standard.set(true, forKey: "launched")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let a = NSAlert()
                a.messageText = "FoldBar 使用指南"
                a.informativeText = "1. ⌘+拖拽 ◀ 到菜单栏靠右位置\n2. 把 ┃ 拖到 ◀ 左边\n3. ⌘+拖拽想隐藏的图标到 ┃ 左边\n4. 点击 ◀ 折叠/展开"
                a.runModal()
            }
        }
    }

    // MARK: - Core

    private var collapseWidth: CGFloat {
        min((NSScreen.main?.frame.width ?? 1920) * 2, 4000)
    }

    func expand() {
        separator.length = 1
        toggle.button?.title = "◀"
        collapsed = false
        // Auto-hide
        timer?.invalidate()
        if UserDefaults.standard.bool(forKey: "autoHide") {
            let delay = max(UserDefaults.standard.double(forKey: "autoHideDelay"), 3)
            timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
                self?.collapse()
            }
        }
        // Click-outside monitor
        monitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] _ in
            guard let self, !self.collapsed, UserDefaults.standard.bool(forKey: "autoHide") else { return }
            self.collapse()
        }
    }

    func collapse() {
        separator.length = collapseWidth
        toggle.button?.title = "▶"
        collapsed = true
        timer?.invalidate()
        timer = nil
        if let m = monitor { NSEvent.removeMonitor(m); monitor = nil }
    }

    // MARK: - Actions

    @objc private func clicked(_ sender: NSStatusBarButton) {
        if NSApp.currentEvent?.type == .rightMouseUp {
            toggle.menu = menu
            toggle.button?.performClick(nil)
            toggle.menu = nil
        } else {
            collapsed ? expand() : collapse()
        }
    }

    @objc private func showPrefs() {
        if let w = prefsWindow { w.makeKeyAndOrderFront(nil); NSApp.activate(ignoringOtherApps: true); return }
        let w = NSWindow(contentViewController: NSHostingController(rootView: PrefsView()))
        w.title = "FoldBar 设置"
        w.styleMask = [.titled, .closable]
        w.center()
        w.isReleasedWhenClosed = false
        w.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        prefsWindow = w
    }
}

// MARK: - Preferences UI

struct PrefsView: View {
    @AppStorage("autoHide") private var autoHide = false
    @AppStorage("autoHideDelay") private var delay = 10.0

    var body: some View {
        Form {
            Toggle("展开后自动折叠", isOn: $autoHide)
            if autoHide {
                HStack {
                    Text("延迟")
                    Slider(value: $delay, in: 3...30, step: 1)
                    Text("\(Int(delay))秒").frame(width: 36)
                }
            }
            Text("⌘+拖拽图标到 ┃ 左边即可隐藏\n点击 ◀/▶ 切换折叠/展开")
                .font(.caption).foregroundColor(.secondary)
        }.frame(width: 300, height: 160).padding()
    }
}
