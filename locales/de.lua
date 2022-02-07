local Translations = {
    error = {
        negative = 'Versuche, einen negativen Betrag zu verkaufen?',
        no_melt = 'Du hast mir nichts zum Schmelzen gegeben...',
        no_items = 'Nicht genug Items',
    },
    success = {
        sold = 'Du hast %{value} x %{value2} für $%{value3} verkauft',
        items_received = 'Du erhälst %{value} x %{value2}',
    },
    info = {
        title = 'Pawn Shop',
        subject = 'Schmelze Items',
        message = 'Wir haben deine Items fertig geschmolzen. Du kannst sie jederzeit abholen.',
        open_pawn = 'Öffne den Pawn Shop',
        sell = 'Verkaufe Items',
        sell_pawn = 'Verkaufe Items dem Pawn Shop',
        melt = 'Schmelze Items',
        melt_pawn = 'Öffne Schmelz-Menü',
        melt_pickup = 'Geschmolzene Items mitnehmen',
        pawn_closed = 'Der Pawn Shop ist geschlossen. Komm zurück zwischen %{value}:00 - %{value2}:00 Uhr',
        sell_items = 'Verkaufspreis $%{value}',
        back = '⬅ Zurück',
        melt_item = 'Schmelzen %{value}',
        max = 'Maximal %{value}',
        submit = 'Schmelzen',
        melt_wait = 'Gib mir %{value} Minuten und ich schmelz dein Zeug.',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
