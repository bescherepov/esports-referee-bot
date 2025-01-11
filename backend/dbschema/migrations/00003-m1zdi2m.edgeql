CREATE MIGRATION m1zdi2mqk2jwksxfcflb5btmriqym7nlm2wvprdpmsb3ant6tj22ja
    ONTO m1xghjzn7ghbtoqhtfr2kmomkthj65ci5d72c2rphshzt5uyn7lyzq
{
  ALTER TYPE default::Referee {
      CREATE PROPERTY gmail: std::str;
  };
};
