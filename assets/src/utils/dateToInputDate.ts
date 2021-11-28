export default function dateToInputDate(date: Date): string {
  const trimmedMilliseconds = date.toISOString().split(".")[0];
  //Trim seconds aswell
  return trimmedMilliseconds.substring(0, trimmedMilliseconds.length - 3);
}
