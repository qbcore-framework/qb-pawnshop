local Translations = {
    error = {
        negative = 'Versuchen Sie, einen negativen Menge zu verkaufen?',
        no_melt = 'Du hast mir nichts zum Schmelzen gegeben...',
        no_items = 'Nicht genug Artikel',
    },
    success = {
        sold = 'Sie haben verkauft %{value} x %{value2} für $%{value3}',
        items_received = 'Sie erhielten %{value} x %{value2}',
    },
    info = {
        title = 'Pfandleihhaus',
        subject = 'Schmelzende Gegenstände',
        message = 'Wir haben Ihre Gegenstände fertig geschmolzen. Du kannst sie jederzeit abholen kommen.',
        open_pawn = 'Öffnen Sie das Pfandhaus',
        sell = 'Artikel verkaufen',
        sell_pawn = 'Gegenstände an das Pfandleihhaus verkaufen',
        melt = 'Gegenstände schmelzen',
        melt_pawn = 'Öffnen Sie die Schmelzerei',
        melt_pickup = 'Geschmolzene Gegenstände abholen',
        pawn_closed = 'Das Pfandhaus ist geschlossen. Komm zurück zwischen %{value}:00 AM - %{value2}:00 PM',
        sell_items = "Verkaufspreis $%{value}',
        back = '⬅ Zurückgehen',
        melt_item = 'Schmelzen %{value}',
        max = 'Maximaler Betragt %{value}',
        submit = 'Schmelzen',
        melt_wait = 'Gib mir %{value} Minuten und ich habe dein Zeug geschmolzen',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
