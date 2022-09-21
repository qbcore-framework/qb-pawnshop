local Translations = {
    error = {
        negative = 'Proovid müüa negatiivset summat?',
        no_melt = 'Sa ei andnud mulle midagi sulatada...',
        no_items = 'Pole piisavalt esemeid',
    },
    success = {
        sold = 'Sa müüsid %{value} x %{value2} hinnaga $%{value3}',
        items_received = 'Sa said %{value} x %{value2}',
    },
    info = {
        title = 'Pandimaja',
        subject = 'Sulatame esemeid',
        message = 'Lõpetasime teie esemete sulatamise. Neile võib järgi tulla igal hetkel.',
        open_pawn = 'Ava pandimaja',
        sell = 'Müü esemeid',
        sell_pawn = 'Müü esemeid pandimajale',
        melt = 'Sulata esemeid',
        melt_pawn = 'Ava sulatuskoda',
        melt_pickup = 'Korja üles sulatatud esemed',
        pawn_closed = 'Pandimaja on suletud. Tulge tagasi ajavahemikus %{value}:00 AM - %{value2}:00 PM',
        sell_items = 'Müügihind $%{value}',
        back = '⬅ Mine tagasi',
        melt_item = 'Sulata %{value}',
        max = 'Maksimaalne kogus %{value}',
        submit = 'Sulata',
        melt_wait = 'Anna mulle %{value} minutit ja ma sulatan kõik su asjad ära.',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})