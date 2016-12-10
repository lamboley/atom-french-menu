PU = require './preferences-util'

class PreferencesSettings

  @localize: () ->

    @defS = window.FrenchMenu.defS.Settings
    @sv = document.querySelector('.settings-view')

    # Settings panel
    @localizeSettingsPanel()

    # Keybindings
    @localizeKeybindingsPanel()

    # Themes panel
    @localizeThemesPanel()

    # Updates panel
    @localizeUpdatesPanel()

    # Install panel
    @localizeInstallPanel()

    # Buttons
    PU.applyButtonToolbar()

  @localizeSettingsPanel: () ->
    # Notes
    for note in @defS.settings.notes
      info = @sv.querySelector("[id='#{note.id}']")
      unless PU.isAlreadyLocalized(info)
        info.innerHTML = note.html
        info.setAttribute('data-localized', 'true')

    # Every settings item
    for d in @defS.settings.controls
      applyTextContentBySettingsId(d)

  applyTextContentBySettingsId = (data) ->
    el = document.querySelector("[id='#{data.id}']")
    return unless el
    ctrl = el.closest('.control-group')
    PU.applyTextWithOrg(ctrl.querySelector('.setting-title'), data.title)
    PU.applyTextWithOrg(ctrl.querySelector('.setting-description'), data.desc)
    return unless data.select
    for o in el.querySelectorAll("option")
      v = o.attributes["value"].value
      o.innerText = data.select[v]

  @localizeKeybindingsPanel: () =>
    info = @sv.querySelector('.keybinding-panel>div:nth-child(2)')
    unless PU.isAlreadyLocalized(info)
      info.querySelector('span:nth-child(2)').textContent = "Vous pouvez modifier ces raccourcis claviers en les copiant ( "
      info.querySelector('span:nth-child(4)').textContent = ") et en les collant dans"
      info.querySelector('a.link').textContent = " votre fichier de raccourcis clavier"
      span = document.createElement('span')
      span.textContent = "."
      info.appendChild(span)
      info.setAttribute('data-localized', 'true')

  @localizeThemesPanel: () =>
    info = @sv.querySelector('.themes-panel>div>div:nth-child(2)')
    unless PU.isAlreadyLocalized(info)
      info.querySelector('span').textContent = "Vous pouvez aussi ouvrir"
      info.querySelector('a.link').textContent = " votre feuille de style "
      span = document.createElement('span')
      span.textContent = "pour modifier l'apparence d'Atom."
      info.appendChild(span)
      tp1 = @sv.querySelector('.themes-picker>div:nth-child(1)')
      tp1.querySelector('.setting-title').textContent = "Thème de l'interface"
      tp1.querySelector('.setting-description').textContent = "Modifie l'apparence des onglets, de la barre de statut, la colonne de navigation et des menus déroulants."
      tp2 = @sv.querySelector('.themes-picker>div:nth-child(2)')
      tp2.querySelector('.setting-title').textContent = "Thème de la syntaxe"
      tp2.querySelector('.setting-description').textContent = "Modifie l'apparence du texte dans l'éditeur."
      info.setAttribute('data-localized', 'true')

  @localizeUpdatesPanel: () =>
    PU.applySpecialHeading(@sv, "Available Updates", 2, "Mises à jour disponibles")
    PU.applyTextWithOrg(@sv.querySelector('.update-all-button.btn-primary'), "Tout mettre à jour")
    PU.applyTextWithOrg(@sv.querySelector('.update-all-button:not(.btn-primary)'), "Rechercher des mises à jour")
    PU.applyTextWithOrg(@sv.querySelector('.alert.icon-hourglass'), "Recherche de mises à jour...")
    PU.applyTextWithOrg(@sv.querySelector('.alert.icon-heart'), "Tous les packages installés sont à jour ！")

  @localizeInstallPanel: () ->
    PU.applySectionHeadings()
    inst = document.querySelector('div.section:not(.themes-panel)')
    info = inst.querySelector('.native-key-bindings')
    unless PU.isAlreadyLocalized(info)
      info.querySelector('span:nth-child(2)').textContent = "Les packages sont publiés sur "
      tc = info.querySelector('span:nth-child(4)')
      tc.textContent = tc.textContent.replace("and are installed to", "et sont installés dans le répertoire suivant : ")
      span = document.createElement('span')
      span.textContent = ""
      info.appendChild(span)
      info.setAttribute('data-localized', 'true')
    PU.applyTextWithOrg(inst.querySelector('.search-container .btn:nth-child(1)'), "Packages")
    PU.applyTextWithOrg(inst.querySelector('.search-container .btn:nth-child(2)'), "Thèmes")


module.exports = PreferencesSettings
