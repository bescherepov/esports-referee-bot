CREATE MIGRATION m1fxnaukrapyxqrajj77khugywiivb6a7q3w5um53u2h67lgobsp6q
    ONTO m1zdi2mqk2jwksxfcflb5btmriqym7nlm2wvprdpmsb3ant6tj22ja
{
  ALTER TYPE default::ExternalRefParticipation {
      CREATE LINK referee: default::Referee {
          ON TARGET DELETE DELETE SOURCE;
      };
      ALTER PROPERTY roleOnTour {
          RESET OPTIONALITY;
      };
      ALTER PROPERTY tourName {
          RESET OPTIONALITY;
      };
  };
};
