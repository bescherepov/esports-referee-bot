module default {
    scalar type TourStatus extending enum<Registering, Running, Finished>;
    type Tournament {
        required name: str;
        required url: str;
        required start_date: datetime;
        required end_date: datetime;
        required status: TourStatus;
    }
    type TourMatch {
        required name: str;
    }
}
