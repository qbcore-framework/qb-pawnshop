local Translations = {
    error = {
        negative = 'Prøver at sælge en negativ mængde?',
        no_melt = 'Du gav mig ikke noget at smelte...',
        no_items = 'Ikke nok genstande',
        inventory_full = 'Inventaret er for fuldt til at modtage alle mulige genstande. Prøv at sikre dig, at inventaret ikke er fuldt næste gang. Tabte genstande: %{value}'
    },
    success = {
        sold = 'Du har solgt %{value} x %{value2} for $%{value3}',
        items_received = 'Du har modtaget %{value} x %{value2}',
    },
    info = {
        title = 'Pantebutik',
        subject = 'Smeltning af genstande',
        message = 'Vi har færdiggjort smeltning af dine genstande. Du kan komme og afhente dem når som helst.',
        open_pawn = 'Åbn pantebutikken',
        sell = 'Sælg genstande',
        sell_pawn = 'Sælg genstande til pantebutikken',
        melt = 'Smelt genstande',
        melt_pawn = 'Åbn smeltebutikken',
        melt_pickup = 'Hent smeltede genstande',
        pawn_closed = 'Pantebutikken er lukket. Kom tilbage mellem kl. %{value} - %{value2}',
        sell_items = 'Salgspris $%{value}',
        back = '⬅ Gå tilbage',
        melt_item = 'Smelt %{value}',
        max = 'Maksimal mængde %{value}',
        submit = 'Smelt',
        melt_wait = 'Giv mig %{value} minutter, og jeg vil have dine ting smeltet',
    }
}

if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end