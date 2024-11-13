local Translations = {
    error = {
        negative = 'Je kunt niet in het negatieve gaan, FOEI!',
        no_melt = 'Je hebt niks bij om te kunnen smelten',
        no_items = 'Niet genoeg materiaal',
        inventory_full = 'Je het niet genoeg plaats in je rugzakje om alles terug mee te nemen, den overschot is voor mij.. Dit ben je kwijt: %{value}'
    },
    success = {
        sold = 'Je hebt %{value} + %{value2} voor  $%{value3} verkocht',
        items_received = 'Je hebt %{value} + %{value2} ontvangen',
    },
    info = {
        title = 'Pawn Shop',
        subject = 'Materialen smelten',
        message = 'We hebben alles gesmolten, kom het maar halen wanneer het uitkomt.',
        open_pawn = 'Open de Pawn Shop',
        sell = 'Items verkopen',
        sell_pawn = 'Verkoop items aan de pawn shop',
        melt = 'Materialen smelten',
        melt_pawn = 'Open de smelt shop',
        melt_pickup = 'Neem je gesmolten items',
        pawn_closed = 'We zijn gesloten, kom terug tussen %{value}:00 AM & %{value2}:00 PM',
        sell_items = 'Verkoopsprijs $%{value}',
        back = '⬅ Ga terug',
        melt_item = 'Smelten %{value}',
        max = 'Maximum  %{value}',
        submit = 'Smelt!',
        melt_wait = 'Geef me %{value} minuutjes en je kan alles komen ophalen',
    }
}

if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Lang or Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
