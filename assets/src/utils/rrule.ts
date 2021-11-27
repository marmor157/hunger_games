import { Frequency, RRule, rrulestr } from "rrule";

export enum PossibleEnds {
  UNTIL,
  COUNT,
  INFINITE,
}

export interface SupportedRRule {
  freq: Frequency;
  interval: number;
}

export function parseRRule(rrule: string): SupportedRRule {
  const rruleobj = rrulestr(rrule);
  return {
    freq: rruleobj.options.freq,
    interval: rruleobj.options.interval,
  };
}

export function parsePossibleEnd({
  options: { until, count },
}: RRule): PossibleEnds {
  if (until) return PossibleEnds.UNTIL;
  if (count) return PossibleEnds.COUNT;
  return PossibleEnds.INFINITE;
}

export function defaultRRule(): SupportedRRule {
  return {
    freq: Frequency.WEEKLY,
    interval: 1,
  };
}
