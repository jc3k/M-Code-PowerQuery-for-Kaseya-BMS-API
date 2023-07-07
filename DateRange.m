let
    DateRange = (days as number, optional includeToday as logical) =>
let
    today = DateTime.LocalNow(),
    past_n_days = Date.AddDays(today, -days + (if includeToday then 1 else 0)),
    toDate = if includeToday = true then today else Date.AddDays(today, -1),
    openDateFrom = DateTime.ToText(past_n_days, "yyyy-MM-dd"),
    openDateTo = DateTime.ToText(toDate, "yyyy-MM-dd")
in
    [From = openDateFrom, To = openDateTo]
in
    DateRange
