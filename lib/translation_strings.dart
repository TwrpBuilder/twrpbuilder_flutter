import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'l10n/messages_all.dart';

class Translations {
  static Future<Translations> load(Locale locale) {
    final String name =
        (locale.countryCode != null && locale.countryCode.isEmpty)
            ? locale.languageCode
            : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((dynamic _) {
      Intl.defaultLocale = localeName;
      return new Translations();
    });
  }

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  String get appName {
    return Intl.message(
      'Twrp Builder',
      name: 'appName',
    );
  }

  String get navigationDrawerOpen {
    return Intl.message(
      'Open navigation drawer',
      name: 'navigationDrawerOpen',
    );
  }

  String get navigationDrawerClose {
    return Intl.message(
      'Close navigation drawer',
      name: 'navigationDrawerClose',
    );
  }

  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
    );
  }

  String get titleActivityResetPassword {
    return Intl.message(
      'ResetPasswordActivity',
      name: 'titleActivityResetPassword',
    );
  }

  String get hintEmail {
    return Intl.message(
      'Email',
      name: 'hintEmail',
    );
  }

  String get forgotPasswordMsg {
    return Intl.message(
      'We just need your registered email to send you password reset instructions',
      name: 'forgotPasswordMsg',
    );
  }

  String get forgotPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotPassword',
    );
  }

  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
    );
  }

  String get btnBack {
    return Intl.message(
      'Back',
      name: 'btnBack',
    );
  }

  String get backupRecovery {
    return Intl.message(
      'Backup Recovery',
      name: 'backupRecovery',
    );
  }

  String get uploadBackup {
    return Intl.message(
      'Upload Backup',
      name: 'uploadBackup',
    );
  }

  String get noNetwork {
    return Intl.message(
      'No Network',
      name: 'noNetwork',
    );
  }

  String get home {
    return Intl.message(
      'Home',
      name: 'home',
    );
  }

  String get about {
    return Intl.message(
      'About',
      name: 'about',
    );
  }

  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
    );
  }

  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
    );
  }

  String get uploading {
    return Intl.message(
      'Uploading',
      name: 'uploading',
    );
  }

  String get failedToUpload {
    return Intl.message(
      'Failed to upload data',
      name: 'failedToUpload',
    );
  }

  String get uploadFinished {
    return Intl.message(
      'Upload complete',
      name: 'uploadFinished',
    );
  }

  String get warningAboutRecoveryBackup {
    return Intl.message(
      'If it takes more then 1 min to backup then send me recovery.img via email',
      name: 'warningAboutRecoveryBackup',
    );
  }

  String get nothingToShow {
    return Intl.message(
      'Nothing to show',
      name: 'nothingToShow',
    );
  }

  String get somethingWentWrong {
    return Intl.message(
      'Oops! Something went wrong',
      name: 'somethingWentWrong',
    );
  }

  String get contributionCounterInfo {
    return Intl.message(
      'Made %d contributions',
      name: 'contributionCounterInfo',
    );
  }

  String get connectingToGithub {
    return Intl.message(
      'Connecting to Github…',
      name: 'connectingToGithub',
    );
  }

  String get enterUrlOfRecovery {
    return Intl.message(
      'Enter Url of recovery',
      name: 'enterUrlOfRecovery',
    );
  }

  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
    );
  }

  String get cancelUpload {
    return Intl.message(
      'Cancel Upload',
      name: 'cancelUpload',
    );
  }

  String get cancelWarning {
    return Intl.message(
      'Are you sure you want to cancel?',
      name: 'cancelWarning',
    );
  }

  String get selectFile {
    return Intl.message(
      'Please select a file',
      name: 'selectFile',
    );
  }

  String get enterUrl {
    return Intl.message(
      'Please Enter Url',
      name: 'enterUrl',
    );
  }

  String get buildStatus {
    return Intl.message(
      'Build Status',
      name: 'buildStatus',
    );
  }

  String get queue {
    return Intl.message(
      'Queue',
      name: 'queue',
    );
  }

  String get running {
    return Intl.message(
      'Running',
      name: 'running',
    );
  }

  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
    );
  }

  String get makeRequest {
    return Intl.message(
      'Make Request',
      name: 'makeRequest',
    );
  }

  String get recovery {
    return Intl.message(
      'Recovery',
      name: 'recovery',
    );
  }

  String get download {
    return Intl.message(
      'Download',
      name: 'download',
    );
  }

  String get flash {
    return Intl.message(
      'flash',
      name: 'flash',
    );
  }

  String get rejected {
    return Intl.message(
      'Rejected',
      name: 'rejected',
    );
  }

  String get quit {
    return Intl.message(
      'Quit',
      name: 'quit',
    );
  }

  String get selectLang {
    return Intl.message(
      'Select Language',
      name: 'selectLang',
    );
  }

  String get checkingForUpdates {
    return Intl.message(
      'Checking for updates…',
      name: 'checkingForUpdates',
    );
  }

  String get restartChange {
    return Intl.message(
      'Restart app to apply changes',
      name: 'restartChange',
    );
  }

  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
    );
  }

  String get language {
    return Intl.message(
      'Language',
      name: 'language',
    );
  }

  String get checkForUpdate {
    return Intl.message(
      'Check for update',
      name: 'checkForUpdate',
    );
  }

  String get disableNotification {
    return Intl.message(
      'Disable Notification',
      name: 'disableNotification',
    );
  }

  String get officialWebsite {
    return Intl.message(
      'Official Website',
      name: 'officialWebsite',
    );
  }

  String get xdaThread {
    return Intl.message(
      'Xda Thread',
      name: 'xdaThread',
    );
  }

  String get source {
    return Intl.message(
      'Source',
      name: 'source',
    );
  }

  String get telegramSupport {
    return Intl.message(
      'Telegram Support',
      name: 'telegramSupport',
    );
  }

  String get noRunningBuilds {
    return Intl.message(
      'No running builds',
      name: 'noRunningBuilds',
    );
  }

  String get noBuildsFound {
    return Intl.message(
      'No builds found',
      name: 'noBuildsFound',
    );
  }

  String get noBuildsInQueue {
    return Intl.message(
      'No Builds in Queue',
      name: 'noBuildsInQueue',
    );
  }

  String get date {
    return Intl.message(
      'Date',
      name: 'date',
    );
  }

  String get model {
    return Intl.message(
      'Model',
      name: 'model',
    );
  }

  String get board {
    return Intl.message(
      'Board',
      name: 'board',
    );
  }

  String get brand {
    return Intl.message(
      'Brand',
      name: 'brand',
    );
  }

  String get developer {
    return Intl.message(
      'Developer',
      name: 'developer',
    );
  }

  String get rejectedBy {
    return Intl.message(
      'Rejected by',
      name: 'rejectedBy',
    );
  }

  String get note {
    return Intl.message(
      'Note',
      name: 'note',
    );
  }

  String get oneTimeRequest {
    return Intl.message(
      "You can make request one time only from this device . If you're facing any issues then please contact via Xda",
      name: 'oneTimeRequest',
    );
  }

  String get createFolderHint {
    return Intl.message(
      'Enter Folder Name Here',
      name: 'createFolderHint',
    );
  }

  String get worksOrNot {
    return Intl.message(
      "Please check the box if it worked or if it didn't work",
      name: 'worksOrNot',
    );
  }

  String get tellUsMoreOptional {
    return Intl.message(
      'Tell us more (optional)',
      name: 'tellUsMoreOptional',
    );
  }

  String get notWorks {
    return Intl.message(
      'not works',
      name: 'notWorks',
    );
  }

  String get works {
    return Intl.message(
      'works',
      name: 'works',
    );
  }

  String get feedback {
    return Intl.message(
      'Feedback',
      name: 'feedback',
    );
  }

  String get send {
    return Intl.message(
      'Send',
      name: 'send',
    );
  }

  String get sending {
    return Intl.message(
      'Sending…',
      name: 'sending',
    );
  }

  String get feedbackSent {
    return Intl.message(
      'Feedback sent',
      name: 'feedbackSent',
    );
  }

  String get feedbackFailed {
    return Intl.message(
      'Failed to send feedback',
      name: 'feedbackFailed',
    );
  }

  String get noRejected {
    return Intl.message(
      'No rejected builds',
      name: 'noRejected',
    );
  }

  String get contributors {
    return Intl.message(
      'Contributors',
      name: 'contributors',
    );
  }

  String get ourTeam {
    return Intl.message(
      'Our Team',
      name: 'ourTeam',
    );
  }

  String get incomplete {
    return Intl.message(
      'Incomplete',
      name: 'incomplete',
    );
  }

  String get selectStockRecovery {
    return Intl.message(
      'Select Stock Recovery',
      name: 'selectStockRecovery',
    );
  }

  String get generateBackup {
    return Intl.message(
      'Generate Backup',
      name: 'generateBackup',
    );
  }

  String get developedBy {
    return Intl.message(
      'Developed by',
      name: 'developedBy',
    );
  }

  String get twrpBuilderTeam {
    return Intl.message(
      'TWRP Builder Team',
      name: 'twrpBuilderTeam',
    );
  }

  String get todo {
    return Intl.message(
      'TODO',
      name: 'todo',
    );
  }

  String get developerProfile {
    return Intl.message(
      'Developer Profile',
      name: 'developerProfile',
    );
  }

  String get createNewFolder {
    return Intl.message(
      'Create a new Folder here',
      name: 'createNewFolder',
    );
  }

  String get runningInNotRootMode {
    return Intl.message(
      'Running in non-root mode',
      name: 'runningInNotRootMode',
    );
  }

  String get failedToCreateBackup {
    return Intl.message(
      'Failed to create backup',
      name: 'failedToCreateBackup',
    );
  }

  String get backupRecoveryFromPath {
    return Intl.message(
      'Backed up recovery',
      name: 'backupRecoveryFromPath',
    );
  }

  String get folder {
    return Intl.message(
      'Folder',
      name: 'folder',
    );
  }

  String get reachUs {
    return Intl.message(
      'Reach Us',
      name: 'reachUs',
    );
  }

  //TODO Backup size too small. Delete %1$s and create backup again - replace %1$s with %1$variableName
  String get backupSizeTooSmall {
    return Intl.message(
      'Backup size too small. Delete and create backup again',
      name: 'backupSizeTooSmall',
    );
  }

  String get failedToBackup {
    return Intl.message(
      'Failed to backup',
      name: 'failedToBackup',
    );
  }

  String get backupDone {
    return Intl.message(
      'Backup Done',
      name: 'backupDone',
    );
  }

  String get reportABug {
    return Intl.message(
      'Report a bug',
      name: 'reportABug',
    );
  }

  String get androidBelowKITKATNotSupported {
    return Intl.message(
      'Android below KITKAT not supported',
      name: 'androidBelowKITKATNotSupported',
    );
  }

  //TODO Build is ready for %1$s - change variable name here for assigning
  String get buildIsReadyFor {
    return Intl.message(
      'Build is ready for %1',
      name: 'buildIsReadyFor',
    );
  }

  String get youCantExitUntilBackup {
    return Intl.message(
      "You can't exit until backup is finished",
      name: 'youCantExitUntilBackup',
    );
  }

  String get recoveryTooSmall {
    return Intl.message(
      'File size too small, Select a proper recovery file',
      name: 'recoveryTooSmall',
    );
  }

  String get select {
    return Intl.message(
      'Select',
      name: 'select',
    );
  }

  String get rootDir {
    return Intl.message(
      'Default Dir',
      name: 'rootDir',
    );
  }
}
