CREATE MIGRATION m1xghjzn7ghbtoqhtfr2kmomkthj65ci5d72c2rphshzt5uyn7lyzq
    ONTO m17rwugubxf7y4as6ypqmp5xivyn3ye76pqq22q775xmcefygt2ebq
{
  ALTER TYPE default::Tournament {
      ALTER PROPERTY end_date {
          SET TYPE cal::local_date USING (cal::to_local_date(.end_date, 'Russia/Moscow'));
      };
      ALTER PROPERTY start_date {
          SET TYPE cal::local_date USING (cal::to_local_date(.start_date, 'Russia/Moscow'));
      };
  };
};
