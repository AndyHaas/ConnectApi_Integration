import { LightningElement, api, track } from 'lwc';

export default class Orders_CreateOrder_CPE extends LightningElement {
    @api operationType = 'create';
    @api operationMode = 'single';
    @api orderId;
    @api orderNumber;
    @api orderKey;
    @api orderStatus;
    @api customerId;
    @api customerEmail;
    @api billToName;
    @api billToCompany;
    @api billToAddress1;
    @api billToAddress2;
    @api billToCity;
    @api billToState;
    @api billToZip;
    @api billToCountry;
    @api billToPhone;
    @api shipToName;
    @api shipToCompany;
    @api shipToAddress1;
    @api shipToAddress2;
    @api shipToCity;
    @api shipToState;
    @api shipToZip;
    @api shipToCountry;
    @api shipToPhone;
    @api paymentMethod;
    @api paymentAmount;
    @api shippingService;
    @api shippingAmount;
    @api taxAmount;
    @api insuranceAmount;
    @api internationalOptions;
    @api advancedOptions;

    get orderStatusOptions() {
        return [
            { label: 'Awaiting Payment', value: 'awaiting_payment' },
            { label: 'Awaiting Shipment', value: 'awaiting_shipment' },
            { label: 'On Hold', value: 'on_hold' },
            { label: 'Pending Fulfillment', value: 'pending_fulfillment' },
            { label: 'Shipped', value: 'shipped' },
            { label: 'Cancelled', value: 'cancelled' }
        ];
    }

    @track formData = {
        operationType: 'create',
        operationMode: 'single',
        orderId: '',
        orderNumber: '',
        orderKey: '',
        orderStatus: '',
        customerId: '',
        customerEmail: '',
        billToName: '',
        billToCompany: '',
        billToAddress1: '',
        billToAddress2: '',
        billToCity: '',
        billToState: '',
        billToZip: '',
        billToCountry: '',
        billToPhone: '',
        shipToName: '',
        shipToCompany: '',
        shipToAddress1: '',
        shipToAddress2: '',
        shipToCity: '',
        shipToState: '',
        shipToZip: '',
        shipToCountry: '',
        shipToPhone: '',
        paymentMethod: '',
        paymentAmount: 0,
        shippingService: '',
        shippingAmount: 0,
        taxAmount: 0,
        insuranceAmount: 0,
        internationalOptions: '',
        advancedOptions: '',
        items: [],
        metadata: {},
        shipToAddress2: '',
        shipToAddress3: '',
        shipToAddressType: '',
        shipToAddressVerified: false,
        billToAddress2: '',
        billToAddress3: '',
        billToAddressType: '',
        billToAddressVerified: false
    };

    @track errors = {};
    @track showBasicInfo = true;
    @track showCustomerInfo = true;
    @track showShippingInfo = true;
    @track showPaymentInfo = true;
    @track showAdvancedOptions = true;
    @track showBillingInfo = true;

    connectedCallback() {
        // Initialize form data with API values
        this.formData = {
            ...this.formData,
            operationType: this.operationType,
            operationMode: this.operationMode,
            orderId: this.orderId || '',
            orderNumber: this.orderNumber || '',
            orderKey: this.orderKey || '',
            orderStatus: this.orderStatus || '',
            customerId: this.customerId || '',
            customerEmail: this.customerEmail || '',
            billToName: this.billToName || '',
            billToCompany: this.billToCompany || '',
            billToAddress1: this.billToAddress1 || '',
            billToAddress2: this.billToAddress2 || '',
            billToCity: this.billToCity || '',
            billToState: this.billToState || '',
            billToZip: this.billToZip || '',
            billToCountry: this.billToCountry || '',
            billToPhone: this.billToPhone || '',
            shipToName: this.shipToName || '',
            shipToCompany: this.shipToCompany || '',
            shipToAddress1: this.shipToAddress1 || '',
            shipToAddress2: this.shipToAddress2 || '',
            shipToCity: this.shipToCity || '',
            shipToState: this.shipToState || '',
            shipToZip: this.shipToZip || '',
            shipToCountry: this.shipToCountry || '',
            shipToPhone: this.shipToPhone || '',
            paymentMethod: this.paymentMethod || '',
            paymentAmount: this.paymentAmount || 0,
            shippingService: this.shippingService || '',
            shippingAmount: this.shippingAmount || 0,
            taxAmount: this.taxAmount || 0,
            insuranceAmount: this.insuranceAmount || 0,
            internationalOptions: this.internationalOptions || '',
            advancedOptions: this.advancedOptions || '',
            items: [],
            metadata: {}
        };
    }

    toggleSection(event) {
        const section = event.currentTarget.dataset.section;
        this[section] = !this[section];
    }

    handleInputChange(event) {
        const field = event.target.dataset.field;
        const value = event.target.type === 'number' ? parseFloat(event.target.value) : event.target.value;
        this.formData[field] = value;
        this.validateField(field, value);
    }

    validateField(field, value) {
        const requiredFields = [
            'orderStatus', 'customerId', 'customerEmail', 'billToName',
            'billToAddress1', 'billToCity', 'billToState', 'billToZip',
            'billToCountry', 'shipToName', 'shipToAddress1', 'shipToCity',
            'shipToState', 'shipToZip', 'shipToCountry', 'shippingService',
            'shippingAmount', 'taxAmount'
        ];

        if (requiredFields.includes(field) && !value) {
            this.errors[field] = 'This field is required';
        } else if (field === 'customerEmail' && value && !this.isValidEmail(value)) {
            this.errors[field] = 'Please enter a valid email address';
        } else {
            delete this.errors[field];
        }
    }

    isValidEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    handleSave() {
        // Validate all required fields
        const requiredFields = [
            'orderStatus', 'customerId', 'customerEmail', 'billToName',
            'billToAddress1', 'billToCity', 'billToState', 'billToZip',
            'billToCountry', 'shipToName', 'shipToAddress1', 'shipToCity',
            'shipToState', 'shipToZip', 'shipToCountry', 'shippingService',
            'shippingAmount', 'taxAmount'
        ];

        requiredFields.forEach(field => {
            this.validateField(field, this.formData[field]);
        });

        if (Object.keys(this.errors).length > 0) {
            return;
        }

        // Dispatch save event with form data
        const saveEvent = new CustomEvent('save', {
            detail: this.formData
        });
        this.dispatchEvent(saveEvent);
    }

    handleCancel() {
        const cancelEvent = new CustomEvent('cancel');
        this.dispatchEvent(cancelEvent);
    }

    handleAddressChange(event) {
        const type = event.currentTarget.dataset.type;
        const {
            street,
            city,
            country,
            province,
            postalCode,
            addressType,
            verified,
            address2,
            address3
        } = event.detail;
        
        // Update form data based on address type
        if (type === 'shipping') {
            this.formData.shipToAddress1 = street;
            this.formData.shipToAddress2 = address2 || '';
            this.formData.shipToAddress3 = address3 || '';
            this.formData.shipToCity = city;
            this.formData.shipToCountry = country;
            this.formData.shipToState = province;
            this.formData.shipToZip = postalCode;
            this.formData.shipToAddressType = addressType;
            this.formData.shipToAddressVerified = verified;
        } else if (type === 'billing') {
            this.formData.billToAddress1 = street;
            this.formData.billToAddress2 = address2 || '';
            this.formData.billToAddress3 = address3 || '';
            this.formData.billToCity = city;
            this.formData.billToCountry = country;
            this.formData.billToState = province;
            this.formData.billToZip = postalCode;
            this.formData.billToAddressType = addressType;
            this.formData.billToAddressVerified = verified;
        }

        // Validate the address fields
        this.validateAddress(type, event.detail);
    }

    validateAddress(type, addressData) {
        const { street, city, country, province, postalCode, verified } = addressData;
        const prefix = type === 'shipping' ? 'ship' : 'bill';

        // Basic required field validation
        this.validateField(`${prefix}ToAddress1`, street);
        this.validateField(`${prefix}ToCity`, city);
        this.validateField(`${prefix}ToCountry`, country);
        this.validateField(`${prefix}ToState`, province);
        this.validateField(`${prefix}ToZip`, postalCode);

        // Add address verification warning if needed
        if (!verified) {
            this.errors[`${prefix}ToAddressVerified`] = 'Address verification recommended';
        } else {
            delete this.errors[`${prefix}ToAddressVerified`];
        }
    }
} 