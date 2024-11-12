local Translations = {
    error = {
        negative = 'Versuchst du, eine negative Menge zu verkaufen?',
        no_melt = 'Du hast mir nichts zum Schmelzen gegeben...',
        no_items = 'Nicht genug Gegenstände',
        inventory_full = 'Inventar zu voll, um alle möglichen Gegenstände zu erhalten. Stelle sicher, dass dein Inventar das nächste Mal nicht voll ist. Verlorene Gegenstände: %{value}'
    },
    success = {
        sold = 'Du hast %{value} x %{value2} für $%{value3} verkauft',
        items_received = 'Du hast %{value} x %{value2} erhalten',
    },
    info = {
        title = 'Pfandhaus',
        subject = 'Gegenstände schmelzen',
        message = 'Wir haben das Schmelzen deiner Gegenstände abgeschlossen. Du kannst sie jederzeit abholen.',
        open_pawn = 'Pfandhaus öffnen',
        sell = 'Gegenstände verkaufen',
        sell_pawn = 'Gegenstände an das Pfandhaus verkaufen',
        melt = 'Gegenstände schmelzen',
        melt_pawn = 'Schmelz-Shop öffnen',
        melt_pickup = 'Geschmolzene Gegenstände abholen',
        pawn_closed = 'Pfandhaus ist geschlossen. Komm zurück zwischen %{value}:00 Uhr und %{value2}:00 Uhr',
        sell_items = 'Verkaufspreis $%{value}',
        back = '⬅ Zurück',
        melt_item = '%{value} schmelzen',
        max = 'Maximale Menge %{value}',
        submit = 'Schmelzen',
        melt_wait = 'Gib mir %{value} Minuten und ich werde deine Sachen geschmolzen haben',
    }
}


if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end