namespace Contracts.Events;

public record PaymentProcessedEvent(
    int OrderId,
    int UserId,
    int GameId,
    string GameName,
    string UserEmail,
    decimal Price,
    PaymentStatus Status,
    DateTime ProcessedAt);

public enum PaymentStatus
{
    Approved = 1,
    Rejected = 2
}
