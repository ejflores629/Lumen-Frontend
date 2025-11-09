import SwiftUI

struct ChatInputView: View {
    @Binding var input: String
    let isLoading: Bool
    let handleSend: () -> Void
    // ... (Tu código)
    var isSendDisabled: Bool { input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoading }

    var body: some View {
        GeometryReader { proxy in
            let availableWidth = proxy.size.width

            VStack(spacing: 0) {
                Rectangle().frame(height: 1).foregroundColor(AppColors.Light.cardBorder)
                HStack(alignment: .bottom, spacing: 12) {
                    TextEditor(text: $input)
                        .scrollContentBackground(.hidden)
                        .frame(height: input.heightForTextEditor(
                            minHeight: 40,
                            maxHeight: 100,
                            availableWidth: availableWidth
                        ))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(AppColors.Light.backgroundSecondary)
                        .cornerRadius(20)
                        .font(.system(size: 15))
                        .foregroundColor(AppColors.Light.text)
                        .overlay(
                            Text(input.isEmpty ? "Escribe tu mensaje..." : "")
                                .font(.system(size: 15))
                                .foregroundColor(AppColors.Light.textTertiary)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 16)
                                .allowsHitTesting(false), alignment: .topLeading
                        )
                        .disabled(isLoading)

                    Button(action: handleSend) {
                        Image(systemName: "arrow.up")
                            .resizable().scaledToFit().frame(width: 20, height: 20)
                            .foregroundColor(isSendDisabled ? AppColors.Light.textTertiary : AppColors.Light.background)
                    }
                    .frame(width: 40, height: 40)
                    .background(isSendDisabled ? AppColors.Light.backgroundSecondary : AppColors.Light.primary)
                    .clipShape(Circle())
                    .buttonStyle(.plain)
                    .disabled(isSendDisabled)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 12)
                .background(AppColors.Light.background)
            }
            .frame(width: availableWidth, alignment: .center)
        }
        .frame(height: nil)
    }
}

// MARK: - Helpers para ChatSubViews
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = []
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
extension UIRectCorner: @unchecked @retroactive Sendable {}
extension String {
    func heightForTextEditor(
        minHeight: CGFloat,
        maxHeight: CGFloat,
        font: UIFont = .systemFont(ofSize: 15),
        availableWidth: CGFloat,
        horizontalPadding: CGFloat = 32
    ) -> CGFloat {
        let width = max(0, availableWidth - horizontalPadding)
        let bounding = (self as NSString).boundingRect(
            with: CGSize(width: width, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font],
            context: nil
        )
        let estimated = ceil(bounding.height) + 24
        return max(minHeight, min(maxHeight, estimated))
    }
}
