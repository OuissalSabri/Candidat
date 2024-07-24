import { LightningElement, api, wire } from 'lwc';
import getCandidatesByJobOffer from '@salesforce/apex/candidat.getCandidatesByJobOffer';
import { NavigationMixin } from 'lightning/navigation';

export default class Candidat extends NavigationMixin(LightningElement) {
    @api recordId; // L'Id de l'offre d'emploi
    candidates;
    error;

    @wire(getCandidatesByJobOffer, { jobOfferId : '$recordId' })
    wiredCandidates({ error, data }) {
        if (data) {
            this.candidates = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.candidates = undefined;
        }
    }

    handleCandidatClick(event) {
        const candidateId = event.currentTarget.dataset.id;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: candidateId,
                objectApiName: 'Candidat__c',
                actionName: 'view'
            }
        });
    }
}