export default function datetimeToDate(date: Date): string {
  return date.toISOString().split("T")[0];
}
