# Data Design

## 1. UserAccount

```text
username
email
password
```

Dung de dang ky va dang nhap cuc bo.

## 2. TransactionEntry

```text
id
type: income | expense
title
category
amount
date
paymentMethod
icon
```

Dung cho thu nhap va chi phi. Truong `date` la co so de thong ke theo thang/nam.

## 3. SavingsGoal

```text
id
title
targetAmount
currentAmount
deadline
frequency
icon
```

Dung cho muc tieu tiet kiem. Nguoi dung co the nap va rut tien nhieu lan.

## 4. ReminderEntry

```text
id
title
amount
reminderDate
dueDate
frequency
```

Dung cho hoa don va loi nhac.

## 5. Account Ledger

Moi tai khoan co mot ledger rieng:

```text
transactions
goals
reminders
incomeCategories
expenseCategories
budgetLimits
```

Thiet ke nay dam bao tai khoan A khong xem thay thu chi cua tai khoan B.

