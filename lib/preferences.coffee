PU = require './preferences-util'
PreferencesSettings = require './preferences-settings'

class Preferences

  @localize: (defS) ->
    @defS = defS
    @updateSettings()
    atom.workspace.onDidChangeActivePaneItem (item) =>
      if item isnt undefined
        if item.uri isnt undefined
          if item.uri.indexOf('atom://config') isnt -1
            unless window.FrenchMenu.pref.done
              @updateSettings(true)

  @updateSettings: (onSettingsOpen = false) ->
    setTimeout(@delaySettings, 0, onSettingsOpen)

  @delaySettings: (onSettingsOpen) =>
    settingsTab = document.querySelector('.tab-bar [data-type="SettingsView"]')
    settingsEnabled = settingsTab.className.includes 'active' if settingsTab
    return unless settingsTab && settingsEnabled
    try
      # Tab title
      settingsTab.querySelector('.title').textContent = "Paramètres"

      @sv = document.querySelector('.settings-view')

      @loadAllSettingsPanels()

      PreferencesSettings.localize()

      @applyLeftSide()

      # Add Events
      btns = @sv.querySelectorAll('div.section:not(.themes-panel) .search-container .btn')
      for btn in btns
        btn.addEventListener('click', applyInstallPanelOnSwitch)

      window.FrenchMenu.pref.done = true
    catch e
      console.error "日本語化に失敗しました。", e

  @loadAllSettingsPanels: () =>
    # Load all settings panels
    lastMenu = @sv.querySelector('.panels-menu .active a')
    panelMenus = @sv.querySelectorAll('.settings-view .panels-menu li a')
    for pm in panelMenus
      pm.click()
      pm.addEventListener('click', applyInstallPanelOnSwitch)
    # Restore last active menu
    lastMenu.click() if lastMenu

  @applyLeftSide: () =>
    # Left-side menu
    menu = @sv.querySelector('.settings-view .panels-menu')
    return unless menu
    for d in @defS.Settings.menu
      el = menu.querySelector("[name='#{d.label}']>a")
      PU.applyTextWithOrg el, d.value

    # Left-side button
    ext = @sv.querySelector('.settings-view .icon-link-external')
    PU.applyTextWithOrg ext, "Dossier de config."

  applyInstallPanelOnSwitch = () ->
    PU.applySectionHeadings(true)
    PU.applyButtonToolbar()
    inst = document.querySelector('div.section:not(.themes-panel)')
    info = inst.querySelector('.native-key-bindings')
    info.querySelector('span:nth-child(2)').textContent = "Les thèmes et packages sont publiés sur "

module.exports = Preferences
