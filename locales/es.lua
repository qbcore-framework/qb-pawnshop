local Translations = {
    error = {
        negative = '¿Estas intentando vender con una cantidad negativa?',
        no_melt = 'No me diste nada para fundir...',
        no_items = 'No hay suficientes objetos',
    },
    success = {
        sold = 'Has vendido %{value} x %{value2} por $%{value3}',
        items_received = 'Recibiste %{value} x %{value2}',
    },
    info = {
        title = 'Casa de empeño',
        subject = 'Artículos de fusión',
        message = 'Hemos terminado de fundir sus artículos. Puedes venir a recogerlos en cualquier momento..',
        open_pawn = 'Abre la casa de empeño',
        sell = 'Vender artículos',
        sell_pawn = 'Vender artículos a la casa de empeño',
        melt = 'Fundir artículos',
        melt_pawn = 'Abre la fundición',
        melt_pickup = 'Recoger artículos derretidos',
        pawn_closed = 'La casa de empeño está cerrada. Vuelve entre %{value}:00 AM - %{value2}:00 PM',
        sell_items = 'Precio de venta $%{value}',
        back = '⬅ Atrás',
        melt_item = 'Fundir %{value}',
        max = 'Cantidad máxima %{value}',
        submit = 'Fundir',
        melt_wait = 'Dame %{value} minutos y haré que tus cosas se derritan',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
