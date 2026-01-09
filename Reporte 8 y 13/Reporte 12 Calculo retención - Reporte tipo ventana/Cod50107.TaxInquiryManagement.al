codeunit 50107 "Tax Inquiry Management"
{
    procedure ShowTaxInquiry(VendorNo: Code[20]; PostingDate: Date)
    var
        TaxInquiryPage: Page "Tax Inquiry";
    begin
        TaxInquiryPage.SetFilters(VendorNo, PostingDate);
        TaxInquiryPage.RunModal();
    end;
}
